//
//  MovieView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct MovieView: View {
    @EnvironmentObject var movievm: MovieVM
    
    var body: some View {
        GeometryReader{ geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let count = isLandscape ? 4 : 2
            let columns = Array(repeating: GridItem(.flexible(), spacing: 50), count: count)
            
            VStack{
                if let error = movievm.errorMessage{
                    Text(error)
                        .foregroundColor(.red)
                }else if movievm.movies.isEmpty && movievm.errorMessage == nil{
                    ProgressView("Getting data..")
                }else {
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 30){
                            ForEach(movievm.movies) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    VStack(alignment: .center, spacing: 10){
                                        ImageLoad(url: movie.attributes.poster?.absoluteString)
                                            .frame(width: 150, height: 200)
                                            .shadow(radius: 3)
                                        
                                        Text(movie.attributes.title)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                    }
                                }
                                
                                
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                }
            }
        }
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            Task{
                await movievm.loadMovies()
            }
        }
    }
}

#Preview {
    MovieView()
        .environmentObject(MovieVM())
}
