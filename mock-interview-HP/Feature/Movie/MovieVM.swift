//
//  MovieVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import Combine

@MainActor
class MovieVM: ObservableObject {
    @Published var movies: [Resource<MovieAttributes>] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let service = APIService()
    
    func loadMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            self.movies = try await service.getMovies()
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error loading movies: \(error)")
        }
        isLoading = false
    }
}
