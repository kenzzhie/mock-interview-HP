//
//  Movie.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation

struct MovieAttributes: Codable {
    let title: String
    let summary: String?
    let poster: URL?
    let releaseDate: String?
    let rating: String?
    let runningTime: String?
    let budget: String?
    let boxOffice: String?
    let trailer: URL?
    let directors: [String]?
    let producers: [String]?
    let screenwriters: [String]?
    let cinematographers: [String]?
    let editors: [String]?
    let distributors: [String]?
    let musicComposers: [String]?
    let wiki: URL?

    enum CodingKeys: String, CodingKey {
        case title, summary, poster, rating, trailer, wiki
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case budget
        case boxOffice = "box_office"
        case directors, producers, screenwriters, cinematographers, editors, distributors
        case musicComposers = "music_composers"
    }
}
