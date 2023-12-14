//
//  SearchView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    @ObservedObject var viewModel: BookAppViewModel
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(10)
                
                TextField("Search books by title/author", text: $searchText)
                    .font(Font.system(size: 14))
                    .foregroundStyle(.black)
                    .padding(.vertical, 18)
                
                Button {
                    searchText = ""
                    viewModel.searchBooksList = []
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .opacity(searchText.isEmpty ? 0 : 0.8)
                }
                
            }
            .background(.backgroundSearchBar)
            .cornerRadius(10)
            
            Button("Search") {
                viewModel.fetchSearchBooks(query: searchText)
            }
        }
 
    }
}

#Preview {
    SearchView(searchText: .constant("asd"), viewModel: BookAppViewModel())
}
