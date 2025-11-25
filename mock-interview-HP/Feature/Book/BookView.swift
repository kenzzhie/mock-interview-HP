//
//  BookView.swift
//  mock-interview-HP
//
//  Created by Putu A D Kenzhie on 24/11/25.
//

import SwiftUI

struct BookView: View {
    @EnvironmentObject var bookvm: BookVM
    
    var body: some View {
        GeometryReader{ geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let count = isLandscape ? 4 : 2
            let columns = Array(repeating: GridItem(.flexible(), spacing: 50), count: count)
            
            VStack{
                if let error = bookvm.errorMessage{
                    Text(error)
                        .foregroundColor(.red)
                }else if bookvm.books.isEmpty && bookvm.errorMessage == nil{
                    ProgressView("Getting data..")
                }else {
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 30){
                            ForEach(bookvm.books) { book in
                                NavigationLink {
                                    BookDetailView(book: book)
                                } label: {
                                    VStack(alignment: .center, spacing: 10){
                                        ImageLoad(url: book.attributes.cover?.absoluteString)
                                            .frame(width: 150, height: 200)
                                            .shadow(radius: 3)
                                        
                                        Text(book.attributes.title)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                    }
                                }
                                
                                
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                }
            }
        }
        .navigationTitle("Books")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            Task{
                await bookvm.loadBooks()
            }
        }
    }
}

#Preview {
    BookView()
        .environmentObject(BookVM())
}
