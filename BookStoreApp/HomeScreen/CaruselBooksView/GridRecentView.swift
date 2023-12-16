//
//  GridCaruselView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//

import SwiftUI

struct GridRecentView: View {
    
    @ObservedObject var viewModel: CoreData
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.savedRecentBooks.reversed(), id: \.self) { book in
                        RecentBook(coreData: viewModel, title: book.titleName ?? "", author: book.author ?? "", image: book.coverId ?? "")
                    }
                }
                .padding(.horizontal, 5)
            }
            .background(.backgroundApp)
        }
        .onAppear() {
            viewModel.fetchRecentBooks()
        }
    }
}


#Preview {
    GridRecentView(viewModel: CoreData())
}
