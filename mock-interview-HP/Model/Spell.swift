//
//  Spell.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 25/11/25.
//

import Foundation

struct SpellAttributes: Codable {
    let name: String
    let incantation: String?
    let category: String?
    let effect: String?
    let light: String?
    let hand: String?
    let creator: String?
    let image: URL?
    let wiki: URL?
    
    enum CodingKeys: String, CodingKey {
        case name, incantation, category, effect, light, hand, creator, image, wiki
    }
}
