//
//  PotionDetailView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import SwiftUI

struct PotionDetailView: View {
    let potion: Resource<PotionAttributes>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    ImageLoad(url: potion.attributes.image?.absoluteString)
                        .frame(width: 150, height: 200)
                        .shadow(radius: 3)
                    Spacer()
                }
                
                Text(potion.attributes.name)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                
                if potion.attributes.effect != nil || potion.attributes.sideEffects != nil {
                    VStack(alignment: .leading, spacing: 12) {
                        if let effect = potion.attributes.effect {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Effect")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                Text(effect)
                                    .font(.body)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        if let sideEffects = potion.attributes.sideEffects {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Side Effects")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                Text(sideEffects)
                                    .font(.body)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Divider()
                }

                if potion.attributes.difficulty != nil ||
                   potion.attributes.characteristics != nil ||
                   potion.attributes.time != nil ||
                   potion.attributes.inventors != nil ||
                   potion.attributes.manufacturers != nil {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Details").font(.headline).padding(.bottom, 5)
                        
                        if let difficulty = potion.attributes.difficulty {
                            InfoRow(label: "Difficulty", value: difficulty)
                        }
                        if let characteristics = potion.attributes.characteristics {
                            InfoRow(label: "Characteristics", value: characteristics)
                        }
                        if let time = potion.attributes.time {
                            InfoRow(label: "Brew Time", value: time)
                        }
                        if let inventors = potion.attributes.inventors {
                            InfoRow(label: "Inventors", value: inventors)
                        }
                        if let manufacturers = potion.attributes.manufacturers {
                            InfoRow(label: "Manufacturers", value: manufacturers)
                        }
                    }
                    
                    Divider()
                }
                
                Divider()
                
                if let ingredients = potion.attributes.ingredients {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients").font(.headline)
                        Text(ingredients)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                if let wiki = potion.attributes.wiki {
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
    let mockAttributes = PotionAttributes(
        name: "Polyjuice Potion",
        image: URL(string: "https://static.wikia.nocookie.net/harrypotter/images/a/a2/Polyjuice_Potion.png"),
        effect: "Allows the drinker to assume the form of another person",
        characteristics: "Mud-like consistency, bubbles slowly",
        difficulty: "Advanced",
        ingredients: "Lacewing flies, Leeches, Powdered Bicorn horn, Knotgrass, Fluxweed, Boomslang skin, A bit of the person you want to turn into",
        inventors: nil,
        manufacturers: nil,
        sideEffects: "Attempts to transform into animals may not be reversible",
        time: "One month",
        wiki: nil
    )
    
    let mockResource = Resource(
        id: "potion-1",
        type: "potion",
        attributes: mockAttributes
    )
    
    NavigationStack {
        PotionDetailView(potion: mockResource)
    }
}
