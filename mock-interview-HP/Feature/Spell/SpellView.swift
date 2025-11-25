//
//  SpellView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct SpellView: View {
    @EnvironmentObject var spellvm: SpellVM
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let count = isLandscape ? 4 : 2
            let columns = Array(repeating: GridItem(.flexible(), spacing: 50), count: count)
            
            VStack {
                if spellvm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = spellvm.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 50) {
                                ForEach(spellvm.spells) { spell in
                                    NavigationLink {
                                        SpellDetailView(spell: spell)
                                    } label: {
                                        VStack(spacing: 10) {
                                            ImageLoad(url: spell.attributes.image?.absoluteString)
                                                .frame(width: 150, height: 200)
                                                .shadow(radius: 3)
                                            
                                            Text(spell.attributes.name)
                                                .font(.subheadline)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 40)
                            .id("Top")
                        }
                        .onChange(of: spellvm.currentPage) { _, _ in
                            withAnimation {
                                proxy.scrollTo("Top", anchor: .top)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Spells")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                HStack {
                    Button {
                        Task { await spellvm.previousPage() }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .padding(15)
                    }
                    .glassEffect()
                    .disabled(!spellvm.hasPreviousPage)
                    
                    Spacer()
                    
                    Text("Page \(spellvm.currentPage)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button {
                        Task { await spellvm.nextPage() }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .bold))
                            .padding(15)
                    }
                    .glassEffect()
                    .disabled(!spellvm.hasNextPage)
                }
                .padding(.horizontal, 30)
            }
            .padding(.bottom, 20)
        }
        .task {
            await spellvm.loadSpells()
        }
    }
}

#Preview {
    NavigationStack {
        SpellView()
            .environmentObject(SpellVM())
    }
}
