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
                HStack {
                    Spacer()
                    ImageLoad(url: spell.attributes.image?.absoluteString)
                        .frame(width: 150, height: 200)
                        .shadow(radius: 3)
                    Spacer()
                }
                VStack(spacing: 10) {
                    Text(spell.attributes.name)
                        .font(.title)
                        .bold()
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
                
                if spell.attributes.incantation != nil ||
                   spell.attributes.hand != nil ||
                   spell.attributes.light != nil ||
                   spell.attributes.creator != nil {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Spell Info").font(.headline)
                        
                        if let incantation = spell.attributes.incantation {
                            InfoRow(label: "Incantation", value: incantation)
                        }
                        
                        if let hand = spell.attributes.hand {
                            InfoRow(label: "Movement", value: hand)
                        }
                        
                        if let light = spell.attributes.light {
                            InfoRow(label: "Light", value: light)
                        }
                        
                        if let creator = spell.attributes.creator {
                            InfoRow(label: "Creator", value: creator)
                        }
                    }
                    
                    Divider()
                }
                
                Divider()
                
                if let effect = spell.attributes.effect {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Effect").font(.headline)
                        Text(effect)
                            .font(.body)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if let wiki = spell.attributes.wiki {
                    Link("Read on PotterDB", destination: wiki)
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                }
                
                
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
