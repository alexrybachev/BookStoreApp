//
//  EmptyView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct EmptyViewSearch: View {
    @Binding var query: String
    @ObservedObject var viewModel: BookAppViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        Text("\(viewModel.searchBooksList.count)")
 
        VStack {
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                ForEach(viewModel.searchBooksList, id: \.isbn) { book in
                    ItemViewSearch(book: book)
                }
            }
        
//        NavigationView {
//            ScrollView(showsIndicators: false) {
//                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
//                    ForEach(viewModel.searchBooksList, id: \.isbn) { book in
//                        ItemViewSearch(book: book)
//                    }
//                }
//                .padding(.horizontal, 5)
//            }
//            .background(.yellow)
        }
    }
}



#Preview {
    EmptyViewSearch(query: .constant("asasd"), viewModel: BookAppViewModel())
}
