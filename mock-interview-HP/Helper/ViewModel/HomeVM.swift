//
//  HomeVM.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HomeVM: ObservableObject {
    @Published var recommendation: AnyRecommendation?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = APIService()
    
    func loadRecommendation() async {
        isLoading = true
        errorMessage = nil
        
        do {
            recommendation = try await service.getDailyRecommendation()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
