//
//  ImageLoad.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import SwiftUI

struct ImageLoad: View {
    
    @StateObject private var imageLoader = ImageLoader()
    let url: String?
    
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if imageLoader.errorMessage != nil {
                ZStack {
                    Color.gray.opacity(0.3)
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.gray)
                }
            } else {
                ZStack {
                    Color.gray.opacity(0.3)
                    ProgressView()
                }
            }
        }
        .onAppear {
            imageLoader.fetchImage(url: url)
        }
    }
}
#Preview {
    ImageLoad(url: nil)
}
