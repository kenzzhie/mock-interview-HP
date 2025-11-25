//
//  mock_interview_HPApp.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

@main
struct mock_interview_HPApp: App {
    @StateObject private var bookVM = BookVM()
    @StateObject private var characterVM = CharacterVM()
    @StateObject private var chapterVM = ChapterVM()
    @StateObject private var spellVM = SpellVM()
    @StateObject private var movieVM = MovieVM()
    @StateObject private var potionVM = PotionVM()
    @StateObject private var homeVM = HomeVM()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(.black)
                .preferredColorScheme(.light)
                .environmentObject(bookVM)
                .environmentObject(characterVM)
                .environmentObject(chapterVM)
                .environmentObject(spellVM)
                .environmentObject(movieVM)
                .environmentObject(potionVM)
                .environmentObject(homeVM)
        }
    }
}
