//
//  HomeView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeVM
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30){
                if let rec = homeVM.recommendation {
                    VStack(alignment: .center, spacing: 20){
                        Text("Daily Recomendation")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        RecommendationCard(rec: rec)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                
                VStack(alignment: .leading) {
                    Text("Discover")
                        .font(.title2)
                        .fontWeight(.semibold)
                    NavigationLink(destination: BookView()) {
                        HStack {
                            Label("Books", systemImage: "book.closed")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .tint(.black)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    NavigationLink(destination: CharacterView()) {
                        HStack {
                            Label("Characters", systemImage: "person.2.crop.square.stack")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .tint(.black)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    NavigationLink(destination: MovieView()) {
                        HStack {
                            Label("Movies", systemImage: "film")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .tint(.black)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))                    }
                    
                    NavigationLink(destination: PotionView()) {
                        HStack {
                            Label("Potions", systemImage: "flask")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .tint(.black)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    NavigationLink(destination: SpellView()) {
                        HStack {
                            Label("Spells", systemImage: "wand.and.stars")
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .tint(.black)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                
                
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Harry Potter Wiki")
            .task {
                await homeVM.loadRecommendation()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeVM())
}
