//
//  Character.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import Foundation

struct CharacterAttributes: Codable {
    let name: String
    let slug: String?
    let image: URL?
    let wiki: URL?
    let born: String?
    let died: String?
    let gender: String?
    let species: String?
    let height: String?
    let weight: String?
    let hairColor: String?
    let eyeColor: String?
    let skinColor: String?
    let bloodStatus: String?
    let maritalStatus: String?
    let nationality: String?
    let animagus: String?
    let boggart: String?
    let house: String?
    let patronus: String?
    let aliasNames: [String]?
    let familyMembers: [String]?
    let jobs: [String]?
    let romances: [String]?
    let titles: [String]?
    let wands: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name, slug, image, wiki
        case born, died, gender, species, height, weight, animagus, boggart, house, patronus, nationality
        case jobs, romances, titles, wands
        
        case hairColor = "hair_color"
        case eyeColor = "eye_color"
        case skinColor = "skin_color"
        case bloodStatus = "blood_status"
        case maritalStatus = "marital_status"
        case aliasNames = "alias_names"
        case familyMembers = "family_members"
    }
}



