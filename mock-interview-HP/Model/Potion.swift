//
//  Potion.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import Foundation

struct PotionAttributes: Codable {
    let name: String
    let image: URL?
    let effect: String?
    let characteristics: String?
    let difficulty: String?
    let ingredients: String?
    let inventors: String?
    let manufacturers: String?
    let sideEffects: String?
    let time: String?
    let wiki: URL?
    
    enum CodingKeys: String, CodingKey {
        case name, image, effect, characteristics, difficulty, ingredients
        case inventors, manufacturers, time, wiki
        case sideEffects = "side_effects"
    }
}
