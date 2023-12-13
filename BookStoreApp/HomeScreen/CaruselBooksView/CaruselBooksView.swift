//
//  CaruselBooksView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 06.12.2023.
//

import SwiftUI

struct CaruselBooksView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    private let rows = [GridItem()]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            //                HStack(spacing: 20) {
            //                    ForEach(viewModel.topTrends, id: \.key) { book in
            //                        BookCaruselView(book: book)
            //                    }
            //                }
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(viewModel.topTrends, id: \.key) { book in
                    NavigationLink(destination: ProductView(book: book)) {
                        BookCaruselView(book: book)
                    }
                }
            }
        }
    }
}

#Preview {
    CaruselBooksView(viewModel: BookAppViewModel())
}
