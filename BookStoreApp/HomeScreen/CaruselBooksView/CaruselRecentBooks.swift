//
//  RecentBooks.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//


import SwiftUI

struct CaruselRecentBooks: View {
    
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
                ForEach(coreData.savedRecentBooks.reversed(), id: \.self) { book in
                    NavigationLink(destination: ProductView(keyBook: book.key ?? "", iaBook: book.iaBooks ?? "", authorName: book.author ?? "")) {
                        RecentBook( coreData: coreData, title: book.titleName ?? "", author: book.author ?? "", image: book.coverId ?? "")
                    }
                }
            }
        }
    }
}


#Preview {
    CaruselRecentBooks(coreData: CoreData())
}

