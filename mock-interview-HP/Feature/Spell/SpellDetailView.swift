//
//  SpellDetailView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import SwiftUI

struct SpellDetailView: View {
    let spell: Resource<SpellAttributes>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(spacing: 10) {
                    Text(spell.attributes.name)
                        .font(.largeTitle).bold()
                        .multilineTextAlignment(.center)
                    
                    if let category = spell.attributes.category {
                        Text(category.uppercased())
                            .font(.caption)
                            .padding(5)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    if let incantation = spell.attributes.incantation {
                        InfoRow(label: "Incantation:", value: incantation)
                    }
                    
                    if let hand = spell.attributes.hand {
                        InfoRow(label: "Movement:", value: hand)
                    }
                    
                    if let light = spell.attributes.light {
                        InfoRow(label: "Light:", value: light)
                    }
                    
                    if let effect = spell.attributes.effect {
                        InfoRow(label: "Effect:", value: effect)
                    }
                }
                .padding()
                
                Divider()
                
                
            }
            .padding()
        }
    }
}

#Preview {
    let mockAttributes = SpellAttributes(
        name: "Wingardium Leviosa",
        incantation: "Win-GAR-dium Levi-O-sa",
        category: "Charm",
        effect: "Levitates objects",
        light: "None",
        hand: "Swish and flick",
        creator: "Jarleth Hobart",
        image: URL(string: "https://static.wikia.nocookie.net/harrypotter/images/4/43/Wingardium_Leviosa_PM.png"),
        wiki: nil
    )

    let mockResource = Resource(
        id: "spell-1",
        type: "spell",
        attributes: mockAttributes
    )

    NavigationStack {
        SpellDetailView(spell: mockResource)
    }
}
