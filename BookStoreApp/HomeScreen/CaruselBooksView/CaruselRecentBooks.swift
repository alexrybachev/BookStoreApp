//
//  RecentBooks.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//


import SwiftUI

struct CaruselRecentBooks: View {
    
    @EnvironmentObject var coreData: CoreData
    
    private let rows = [GridItem()]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(coreData.savedRecentBooks.reversed(), id: \.self) { book in
                    NavigationLink(destination: ProductView(keyBook: book.key ?? "", iaBook: book.iaBooks ?? "", authorName: book.author ?? "")) {
                        RecentBook(title: book.titleName ?? "",
                                   author: book.author ?? "",
                                   image: book.coverId ?? "")
                    }
                }
            }
        }
    }
}


#Preview {
    CaruselRecentBooks()
}

