//
//  CharacterDetailView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Resource<CharacterAttributes>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Spacer()
                    AsyncImage(url: character.attributes.image) { img in
                        img.resizable().scaledToFit()
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray.opacity(0.3))
                            .padding()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    Spacer()
                }
                
                VStack(spacing: 5) {
                    Text(character.attributes.name)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    if let house = character.attributes.house {
                        Text(house)
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("General Information").font(.headline)
                    
                    if let species = character.attributes.species {
                        InfoRow(label: "Species", value: species)
                    }
                    if let gender = character.attributes.gender {
                        InfoRow(label: "Gender", value: gender)
                    }
                    if let born = character.attributes.born {
                        InfoRow(label: "Born", value: born)
                    }
                    if let died = character.attributes.died {
                        InfoRow(label: "Died", value: died)
                    }
                    if let blood = character.attributes.bloodStatus {
                        InfoRow(label: "Blood Status", value: blood)
                    }
                    if let marital = character.attributes.maritalStatus {
                        InfoRow(label: "Marital Status", value: marital)
                    }
                }
                
                Divider()
                
                if character.attributes.height != nil || character.attributes.eyeColor != nil || character.attributes.hairColor != nil {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Appearance").font(.headline)
                        
                        if let height = character.attributes.height {
                            InfoRow(label: "Height", value: height)
                        }
                        if let eyes = character.attributes.eyeColor {
                            InfoRow(label: "Eyes", value: eyes)
                        }
                        if let hair = character.attributes.hairColor {
                            InfoRow(label: "Hair", value: hair)
                        }
                    }
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Magical Info").font(.headline)
                    
                    if let patronus = character.attributes.patronus {
                        InfoRow(label: "Patronus", value: patronus)
                    }
                    if let boggart = character.attributes.boggart {
                        InfoRow(label: "Boggart", value: boggart)
                    }
                    if let animagus = character.attributes.animagus {
                        InfoRow(label: "Animagus", value: animagus)
                    }
                    
                    if let wands = character.attributes.wands, !wands.isEmpty {
                        HStack(alignment: .top) {
                            Text("Wand(s)")
                                .foregroundColor(.secondary)
                                .frame(width: 100, alignment: .leading)
                                .font(.subheadline)
                            
                            VStack(alignment: .leading) {
                                ForEach(wands, id: \.self) { wand in
                                    Text("• \(wand)")
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                        }
                    }
                }
                
                Divider()
                
                Group {
                    if let jobs = character.attributes.jobs, !jobs.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Occupations").font(.headline)
                            ForEach(jobs, id: \.self) { job in
                                Text("• \(job)").font(.body)
                            }
                        }
                        Divider()
                    }
                    
                    if let aliases = character.attributes.aliasNames, !aliases.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Also Known As").font(.headline)
                            ForEach(aliases, id: \.self) { alias in
                                Text("• \(alias)").italic().font(.body)
                            }
                        }
                        Divider()
                    }
                }
                
                if let wiki = character.attributes.wiki {
                    Link("Read on PotterDB", destination: wiki)
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockAttributes = CharacterAttributes(
        name: "Harry Potter",
        slug: "harry-potter",
        image: URL(string: "https://upload.wikimedia.org/wikipedia/en/d/d7/Harry_Potter_character_poster.jpg"),
        wiki: URL(string: "https://google.com"),
        born: "31 July, 1980",
        died: nil,
        gender: "Male",
        species: "Human",
        height: "5'5\"",
        weight: nil,
        hairColor: "Black",
        eyeColor: "Green",
        skinColor: "Light",
        bloodStatus: "Half-blood",
        maritalStatus: "Married",
        nationality: "British",
        animagus: nil,
        boggart: "Dementor",
        house: "Gryffindor",
        patronus: "Stag",
        aliasNames: ["The Boy Who Lived", "The Chosen One", "Undesirable No. 1"],
        familyMembers: ["Lily Potter (mother)", "James Potter (father)"],
        jobs: ["Head of Auror Office", "Head of Department of Magical Law Enforcement"],
        romances: ["Ginny Weasley", "Cho Chang"],
        titles: ["Triwizard Champion", "Seeker"],
        wands: ["11\", Holly, phoenix feather", "10¾\", Vine wood, dragon heartstring"]
    )
    
    let mockResource = Resource(
        id: "char-1",
        type: "character",
        attributes: mockAttributes
    )
    
    NavigationStack {
        CharacterDetailView(character: mockResource)
    }
}
