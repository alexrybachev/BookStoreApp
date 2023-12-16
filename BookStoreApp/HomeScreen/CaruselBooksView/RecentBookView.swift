//
//  RecentBooks.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//


import SwiftUI

struct RecentBookView: View {
    
//    @ObservedObject var viewModel: BookAppViewModel
    @ObservedObject var coreData: CoreData
    
    private let rows = [GridItem()]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            //                HStack(spacing: 20) {
//                                ForEach(coreData.topTrends, id: \.key) { book in
            //                        BookCaruselView(book: book)
            //                    }
            //                }
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(coreData.savedRecentBooks, id: \.self) { book in
                    NavigationLink(destination: ProductView(keyBook: book.key ?? "", iaBook: book.iaBooks ?? "", authorName: book.author ?? "")) {
//                        RecentCaruselView( title: book.titleName ?? "No title", author: book.author ?? "No author")
                    }
                }
            }
        }
    }
}

#Preview {
    RecentBookView(coreData: CoreData())
}

