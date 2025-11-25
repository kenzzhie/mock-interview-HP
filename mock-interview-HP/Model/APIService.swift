//
//  APIService.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The URL provided was invalid."
        case .invalidResponse: return "The server returned an invalid response."
        case .decodingError(let error): return "Failed to parse data: \(error.localizedDescription)"
        }
    }
}

class APIService {
    private let baseURL = "https://api.potterdb.com/v1"
    
    private func fetch<T: Codable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> APIResponse<T> {
        var components = URLComponents(string: baseURL + endpoint)
        components?.queryItems = queryItems
        
        guard let url = components?.url else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            let result = try JSONDecoder().decode(APIResponse<T>.self, from: data)
            return result
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    
    func getBooks() async throws -> [Resource<BookAttributes>] {
        return try await fetch(endpoint: "/books").data
    }
    
    func getMovies() async throws -> [Resource<MovieAttributes>] {
        return try await fetch(endpoint: "/movies").data
    }
    
    func getCharacters(page: Int = 1, sortByName: Bool = false) async throws -> APIResponse<CharacterAttributes> {
            var query = [
                URLQueryItem(name: "page[number]", value: String(page)),
                URLQueryItem(name: "page[size]", value: "25")
            ]
            
            let sortValue = sortByName ? "name" : "-name"
            query.append(URLQueryItem(name: "sort", value: sortValue))
            
            return try await fetch(endpoint: "/characters", queryItems: query)
        }
    
    func getPotions(page: Int = 1) async throws -> APIResponse<PotionAttributes> {
        let query = [
            URLQueryItem(name: "page[number]", value: String(page)),
            URLQueryItem(name: "page[size]", value: "25")
        ]
        return try await fetch(endpoint: "/potions", queryItems: query)
    }
    
    func getSpells(page: Int = 1) async throws -> APIResponse<SpellAttributes> {
        let query = [
            URLQueryItem(name: "page[number]", value: String(page)),
            URLQueryItem(name: "page[size]", value: "25")
        ]
        return try await fetch(endpoint: "/spells", queryItems: query)
    }
    
    func getChapters(bookID: String) async throws -> [Resource<ChapterAttributes>] {
        return try await fetch(endpoint: "/books/\(bookID)/chapters").data
    }
    
    func getDailyRecommendation() async throws -> AnyRecommendation {
        let category = Int.random(in: 0...1)
        
        switch category {
        case 0:
            let books = try await getBooks()
            guard let random = books.randomElement() else { throw APIError.invalidResponse }
            return .book(random)
        case 1:
            let movies = try await getMovies()
            guard let random = movies.randomElement() else { throw APIError.invalidResponse }
            return .movie(random)
        default:
            let movies = try await getMovies()
            guard let random = movies.randomElement() else { throw APIError.invalidResponse }
            return .movie(random)
        }
    }
}

enum AnyRecommendation {
    case book(Resource<BookAttributes>)
    case movie(Resource<MovieAttributes>)
}
