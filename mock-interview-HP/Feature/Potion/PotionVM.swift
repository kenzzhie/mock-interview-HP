//
//  PotionVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import Combine

@MainActor
class PotionVM: ObservableObject {
    @Published var potions: [Resource<PotionAttributes>] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    @Published private(set) var currentPage = 1
    @Published private(set) var hasNextPage = true
    
    var hasPreviousPage: Bool {
        return currentPage > 1
    }
    
    private let service = APIService()
    
    func loadPotions() async {
        if potions.isEmpty {
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
        potions = []
        errorMessage = nil
        
        do {
            let response = try await service.getPotions(page: page)
            
            self.potions = response.data 
            
            self.currentPage = page
            
            if (response.meta?.pagination?.next) != nil {
                self.hasNextPage = true
            } else {
                self.hasNextPage = false
            }
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error loading potions: \(error)")
        }
        isLoading = false
    }
}
