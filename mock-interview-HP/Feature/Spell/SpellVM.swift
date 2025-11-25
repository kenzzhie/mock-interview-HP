//
//  SpellVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import Combine

@MainActor
class SpellVM: ObservableObject {
    @Published var spells: [Resource<SpellAttributes>] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Pagination State
    @Published private(set) var currentPage = 1
    @Published private(set) var hasNextPage = true
    
    var hasPreviousPage: Bool {
        return currentPage > 1
    }
    
    private let service = APIService()
    
    func loadSpells() async {
        if spells.isEmpty {
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
        spells = [] 
        errorMessage = nil
        
        do {
            let response = try await service.getSpells(page: page)
            
            self.spells = response.data
            self.currentPage = page
            
            if (response.meta?.pagination?.next) != nil {
                self.hasNextPage = true
            } else {
                self.hasNextPage = false
            }
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error loading spells: \(error)")
        }
        isLoading = false
    }
}
