//
//  ChapterVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import Combine

@MainActor
class ChapterVM: ObservableObject {
    @Published var chapters: [Resource<ChapterAttributes>] = []
    @Published var isLoading = false
    
    private let service = APIService()
    
    func loadChapters(for bookID: String) async {
        isLoading = true
        do {
            self.chapters = try await service.getChapters(bookID: bookID)
        } catch {
            print("Error loading chapters: \(error)")
        }
        isLoading = false
    }
}
