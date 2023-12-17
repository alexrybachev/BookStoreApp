//
//  GridCaruselView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//

import SwiftUI

struct GridRecentView: View {
    
    @EnvironmentObject var coreData: CoreData
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(coreData.savedRecentBooks.reversed(), id: \.self) { book in
                        RecentBook(title: book.titleName ?? "",
                                   author: book.author ?? "",
                                   image: book.coverId ?? "")
                    }
                }
                .padding(.horizontal, 5)
            }
            .background(.backgroundApp)
        }
        .onAppear() {
            coreData.fetchRecentBooks()
        }
    }
}


#Preview {
    GridRecentView()
}
