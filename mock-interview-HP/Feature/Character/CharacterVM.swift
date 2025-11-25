//
//  CharacterVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import Combine

@MainActor
class CharacterVM: ObservableObject {
    @Published var characters: [Resource<CharacterAttributes>] = []
    @Published var isSortedByName = true
    @Published var isLoading = false
    
    @Published private(set) var currentPage = 1
    @Published private(set) var hasNextPage = true
    
    var hasPreviousPage: Bool {
        return currentPage > 1
    }
    
    private let service = APIService()
    
    func loadCharacters() async {
        if characters.isEmpty {
            await fetchPage(page: 1)
        }
    }
    
    func nextPage() async {
        guard !isLoading && hasNextPage else { return }
        await fetchPage(page: currentPage + 1)
    }
    
    func previousPage() async {
        guard !isLoading && hasPreviousPage else { return }
        await fetchPage(page: currentPage - 1)
    }
    
    private func fetchPage(page: Int) async {
        isLoading = true
        characters = []
        
        do {
            let response = try await service.getCharacters(page: page, sortByName: isSortedByName)
            
            self.characters = response.data
            self.currentPage = page
            
            if (response.meta?.pagination?.next) != nil {
                self.hasNextPage = true
            } else {
                self.hasNextPage = false
            }
            
        } catch {
            print("Error loading characters: \(error)")
        }
        isLoading = false
    }
    
    func toggleSort() async {
        isSortedByName.toggle()
        await fetchPage(page: 1)
    }
}
