//
//  CharacterView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct CharacterView: View {
    @EnvironmentObject var charVM: CharacterVM
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let count = isLandscape ? 4 : 2
            let columns = Array(repeating: GridItem(.flexible(), spacing: 50), count: count)
            
            VStack {
                if charVM.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 50) {
                                ForEach(charVM.characters) { character in
                                    NavigationLink {
                                        CharacterDetailView(character: character)
                                    } label: {
                                        VStack {
                                            ImageLoad(url: character.attributes.image?.absoluteString)
                                                .frame(width: 150, height: 200)
                                                .shadow(radius: 3)
                                            
                                            Text(character.attributes.name)
                                                .font(.subheadline)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .id("Top")
                        }
                        .onChange(of: charVM.currentPage) { _, _ in
                            withAnimation {
                                proxy.scrollTo("Top", anchor: .top)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Characters")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { await charVM.toggleSort() }
                } label: {
                    Image(systemName: charVM.isSortedByName ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle")
                }
            }
            
        }
        .overlay(alignment: .bottom){
            ZStack(alignment: .bottom) {
                HStack {
                    Button {
                        Task { await charVM.previousPage() }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .padding(15)
                    }
                    .glassEffect()
                    Spacer()
                    Text("Page \(charVM.currentPage)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                    Spacer()
                    Button {
                        Task { await charVM.nextPage() }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                    }
                    .glassEffect()
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottom)
            .padding(.bottom, 20)
        }
        .task {
            await charVM.loadCharacters()
        }
    }
}

#Preview {
    NavigationStack {
        CharacterView()
            .environmentObject(CharacterVM())
    }
}
