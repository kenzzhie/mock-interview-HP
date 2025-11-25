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
    
    // Pagination State
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
        potions = [] // Clear list
        errorMessage = nil
        
        do {
            // Note: Ensure APIService.getPotions returns APIResponse<PotionAttributes>
            let response = try await service.getPotions(page: page)
            
            // Assuming your APIService is fixed to return generic T correctly,
            // otherwise you might need to cast or fix APIService return type.
            // Based on your previous code, getPotions returned SpellAttributes which was an error in APIService.
            // This code assumes you fixed APIService to return PotionAttributes.
             self.potions = response.data as! [Resource<PotionAttributes>]
            
            self.currentPage = page
            
            if let next = response.meta?.pagination?.next {
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
