//
//  Book.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation

struct BookAttributes: Codable {
    let slug: String?
    let title: String
    let summary: String?
    let author: String?
    let releaseDate: String?
    let dedication: String?
    let pages: Int?
    let cover: URL?
    let wiki: URL?

    enum CodingKeys: String, CodingKey {
        case slug, title, summary, author
        case releaseDate = "release_date"
        case dedication, pages, cover, wiki
    }
}

struct ChapterAttributes: Codable {
    let slug: String?
    let title: String
    let summary: String?
    let order: Int?
}
