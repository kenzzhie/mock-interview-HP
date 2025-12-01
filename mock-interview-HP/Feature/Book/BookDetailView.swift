//
//  BookDetailView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct BookDetailView: View {
    let book: Resource<BookAttributes>
    @EnvironmentObject private var chapterVM: ChapterVM
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(spacing: 15) {
                    ImageLoad(url: book.attributes.cover?.absoluteString)
                        .frame(width: 220, height: 300)
                        .shadow(radius: 3)
                    
                    Text(book.attributes.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    if let author = book.attributes.author {
                        Text("by \(author)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
                
                Divider()
                
                if let summary = book.attributes.summary {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Summary").font(.headline)
                        Text(summary)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                }
                
                Divider()
                
                if book.attributes.releaseDate != nil || book.attributes.dedication != nil || book.attributes.pages != nil {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Details").font(.headline)
                        
                        if let releaseDate = book.attributes.releaseDate {
                            InfoRow(label: "Release Date", value: releaseDate)
                        }
                        
                        if let dedication = book.attributes.dedication {
                            InfoRow(label: "Dedication", value: dedication)
                        }
                        
                        if let pages = book.attributes.pages {
                            InfoRow(label: "Pages", value: String(pages))
                        }
                    }
                    Divider()
                }

                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Chapters")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                    
                    if chapterVM.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else if chapterVM.chapters.isEmpty {
                        Text("No chapters found.")
                            .foregroundColor(.secondary)
                            .italic()
                    } else {
                        ForEach(chapterVM.chapters) { chapter in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(chapter.attributes.title)
                                    .font(.headline)
                                
                                if let summary = chapter.attributes.summary, !summary.isEmpty {
                                    Text(summary)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                } else {
                                    Text("No summary available")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .italic()
                                }
                                
                                Divider().padding(.top, 4)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
                await chapterVM.loadChapters(for: book.id)
        }
    }
}

#Preview {
    let mockAttributes = BookAttributes(
        slug: "harry-potter-and-the-philosophers-stone",
        title: "Harry Potter and the Sorcerer's Stone",
        summary: "Harry Potter has no idea how famous he is. That's because he's being raised by his miserable aunt and uncle who are terrified Harry will learn that he's really a wizard, just as his parents were.",
        author: "J.K. Rowling",
        releaseDate: "1997-06-26",
        dedication: "For Jessica, who loves stories, for Anne, who loved them too; and for Di, who heard this one first.",
        pages: 223,
        cover: URL(string: "https://www.wizardingworld.com/images/products/books/HP_PS_US_2.jpg"),
        wiki: URL(string: "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Philosopher%27s_Stone")
    )
    
    let mockBook = Resource(
        id: "mock-id-1",
        type: "book",
        attributes: mockAttributes
    )
    
    NavigationStack {
        BookDetailView(book: mockBook)
            .environmentObject(ChapterVM())
    }
}
