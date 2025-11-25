//
//  MainModel.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let data: [Resource<T>]
    let meta: Meta?
    let links: Links?
}

struct SingleAPIResponse<T: Codable>: Codable {
    let data: Resource<T>
}

struct Resource<T: Codable>: Codable, Identifiable {
    let id: String
    let type: String
    let attributes: T
}

struct Meta: Codable {
    let pagination: Pagination?
}

struct Pagination: Codable {
    let current: Int?
    let next: Int?
    let last: Int?
    let records: Int?
}

struct Links: Codable {
    let current: String?
    let next: String?
    let last: String?
}

