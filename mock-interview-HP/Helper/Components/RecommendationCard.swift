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
                    ImageLoad(url: res.attributes.cover?.absoluteString)
                        .frame(width: 150, height: 200)
                    Text(res.attributes.title).font(.headline)
                }
            case .movie(let res):
                VStack(alignment: .center, spacing: 5) {
                    ImageLoad(url: res.attributes.poster?.absoluteString)
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
