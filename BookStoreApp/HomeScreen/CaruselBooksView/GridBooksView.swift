//
//  GridBooksView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct GridBooksView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.topTrends, id: \.key) { book in
                        BookCaruselView(book: book)
                    }
                }
                .padding(.horizontal, 5)
            }
            .background(.backgroundApp)
        }
    }
}

#Preview {
    GridBooksView(viewModel: BookAppViewModel())
}
