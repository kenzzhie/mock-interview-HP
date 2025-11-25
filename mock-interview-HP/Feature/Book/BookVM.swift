//
//  BookVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import Combine

@MainActor
class BookVM: ObservableObject {
    @Published var books: [Resource<BookAttributes>] = []
    @Published var errorMessage: String?
    
    private let service = APIService()
    
    func loadBooks() async {
        do {
            self.books = try await service.getBooks()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
