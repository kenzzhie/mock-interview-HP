//
//  PotionView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct PotionView: View {
    @EnvironmentObject var potionvm: PotionVM
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let count = isLandscape ? 4 : 2
            let columns = Array(repeating: GridItem(.flexible(), spacing: 50), count: count)
            
            VStack {
                if potionvm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = potionvm.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 50) {
                                ForEach(potionvm.potions) { potion in
                                    NavigationLink {
                                        PotionDetailView(potion: potion)
                                    } label: {
                                        VStack(spacing: 10) {
                                            ImageLoad(url: potion.attributes.image?.absoluteString)
                                                .frame(width: 150, height: 200)
                                                .shadow(radius: 3)
                                            
                                            Text(potion.attributes.name)
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
                        .onChange(of: potionvm.currentPage) { _, _ in
                            withAnimation {
                                proxy.scrollTo("Top", anchor: .top)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Potions")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                HStack {
                    Button {
                        Task { await potionvm.previousPage() }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .padding(15)
                    }
                    .glassEffect()
                    .disabled(!potionvm.hasPreviousPage)
                    
                    Spacer()
                    
                    Text("Page \(potionvm.currentPage)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button {
                        Task { await potionvm.nextPage() }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .bold))
                            .padding(15)
                            
                    }
                    .glassEffect()
                    
                    .disabled(!potionvm.hasNextPage)
                }
                .padding(.horizontal, 30)
            }
            .padding(.bottom, 20)
        }
        .task {
            await potionvm.loadPotions()
        }
    }
}

#Preview {
    NavigationStack {
        PotionView()
            .environmentObject(PotionVM())
    }
}
