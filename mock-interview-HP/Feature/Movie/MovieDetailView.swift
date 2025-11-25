//
//  MovieDetailView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Resource<MovieAttributes>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    ImageLoad(url: movie.attributes.poster?.absoluteString)
                        .frame(width: 220, height: 300)
                        .shadow(radius: 3)
                    Spacer()
                }
                
                VStack(alignment: .center, spacing: 5) {
                    Text(movie.attributes.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    if let rating = movie.attributes.rating {
                        Text("rated \(rating)")
                    }
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                if let summary = movie.attributes.summary {
                    Text("Plot Summary").font(.headline)
                    Text(summary).font(.body)
                }
                
                Divider()
                
                if movie.attributes.releaseDate != nil ||
                   movie.attributes.runningTime != nil ||
                   movie.attributes.budget != nil ||
                   movie.attributes.boxOffice != nil ||
                   (movie.attributes.distributors?.isEmpty == false) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Details").font(.headline)
                        
                        if let release = movie.attributes.releaseDate {
                            InfoRow(label: "Released", value: release)
                        }
                        if let runtime = movie.attributes.runningTime {
                            InfoRow(label: "Runtime", value: runtime)
                        }
                        if let budget = movie.attributes.budget {
                            InfoRow(label: "Budget", value: budget)
                        }
                        if let boxOffice = movie.attributes.boxOffice {
                            InfoRow(label: "Box Office", value: boxOffice)
                        }
                        if let distributors = movie.attributes.distributors, !distributors.isEmpty {
                            InfoRow(label: "Distributor", value: distributors.joined(separator: ", "))
                        }
                    }
                    
                    Divider()
                }

                if (movie.attributes.directors?.isEmpty == false) ||
                   (movie.attributes.producers?.isEmpty == false) ||
                   (movie.attributes.screenwriters?.isEmpty == false) ||
                   (movie.attributes.musicComposers?.isEmpty == false) ||
                   (movie.attributes.cinematographers?.isEmpty == false) ||
                   (movie.attributes.editors?.isEmpty == false) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Cast & Crew").font(.headline)
                        
                        if let directors = movie.attributes.directors, !directors.isEmpty {
                            InfoRow(label: "Directors", value: directors.joined(separator: ", "))
                        }
                        
                        if let producers = movie.attributes.producers, !producers.isEmpty {
                            InfoRow(label: "Producers", value: producers.joined(separator: ", "))
                        }
                        
                        if let writers = movie.attributes.screenwriters, !writers.isEmpty {
                            InfoRow(label: "Writers", value: writers.joined(separator: ", "))
                        }
                        
                        if let music = movie.attributes.musicComposers, !music.isEmpty {
                            InfoRow(label: "Music", value: music.joined(separator: ", "))
                        }
                        
                        if let cinematography = movie.attributes.cinematographers, !cinematography.isEmpty {
                            InfoRow(label: "Cinematography", value: cinematography.joined(separator: ", "))
                        }
                        
                        if let editors = movie.attributes.editors, !editors.isEmpty {
                            InfoRow(label: "Editors", value: editors.joined(separator: ", "))
                        }
                    }
                }
                
                Divider()
                
                VStack(spacing: 10) {
                    if let wiki = movie.attributes.wiki {
                        Link(destination: wiki) {
                            Label("Read on PotterDB", systemImage: "book.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                    }
                    
                    if let trailer = movie.attributes.trailer {
                        Link(destination: trailer) {
                            Label("Watch Trailer", systemImage: "play.rectangle.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    }
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockAttributes = MovieAttributes(
        title: "Harry Potter and the Philosopher's Stone",
        summary: "Harry Potter has no idea how famous he is. That's because he's being raised by his miserable aunt and uncle who are terrified Harry will learn that he's really a wizard, just as his parents were.",
        poster: URL(string: "https://www.wizardingworld.com/images/products/movies/HP_PS_Poster.jpg"),
        releaseDate: "2001-11-16",
        rating: "PG",
        runningTime: "152 mins",
        budget: "$125 million",
        boxOffice: "$974.8 million",
        trailer: nil,
        directors: ["Chris Columbus"],
        producers: ["David Heyman"],
        screenwriters: ["Steve Kloves"],
        cinematographers: ["John Seale"],
        editors: ["Richard Francis-Bruce"],
        distributors: ["Warner Bros."],
        musicComposers: ["John Williams"],
        wiki: URL(string: "https://harrypotter.fandom.com")
    )
    
    let mockResource = Resource(
        id: "movie-1",
        type: "movie",
        attributes: mockAttributes
    )
    
    NavigationStack {
        MovieDetailView(movie: mockResource)
    }
}
