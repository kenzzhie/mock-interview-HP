//
//  RecommendationCard.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import SwiftUI

struct RecommendationCard: View {
    let rec: AnyRecommendation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            switch rec {
            case .book(let res):
                VStack(alignment: .center, spacing: 5) {
                    AsyncImage(url: res.attributes.cover) { $0.resizable().scaledToFit() } placeholder: { Color.gray.opacity(0.3) }
                        .frame(width: 150, height: 200)
                    Text(res.attributes.title).font(.headline)
                }
            case .movie(let res):
                VStack(alignment: .center, spacing: 5) {
                    AsyncImage(url: res.attributes.poster) { $0.resizable().scaledToFit() } placeholder: { Color.gray.opacity(0.3) }
                        .frame(width: 150, height: 200)
                    Text(res.attributes.title).font(.headline)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

//#Preview {
//    RecommendationCard(rec: AnyRecommendation.book(<#Resource<BookAttributes>#>))
//}
