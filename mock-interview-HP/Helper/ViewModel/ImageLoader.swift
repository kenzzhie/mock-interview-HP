//
//  ImageLoader.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import Foundation
import UIKit
import Combine

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidStatusCode(let code):
            return "Server returned status code \(code)"
        case .unknownError(let error):
            return error.localizedDescription
        }
    }
}

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init() {}
    
    func fetchImage(url: String?) {
        guard image == nil && !isLoading else { return }
        
        guard let urlString = url, let fetchURL = URL(string: urlString) else {
            errorMessage = NetworkError.invalidURL.localizedDescription
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self?.errorMessage = NetworkError.invalidStatusCode(statusCode: response.statusCode).localizedDescription
                } else if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.errorMessage = "Unknown data error"
                }
            }
        }
        task.resume()
    }
}
