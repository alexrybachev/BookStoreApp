//
//  SearchView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(.black)
                .padding(10)
            TextField("Search books by title/author", text: $searchText)
                .font(Font.system(size: 21))
                .foregroundStyle(.black)
                .padding(.vertical, 18)
        }
        .background(.backgroundSearchBar)
        .cornerRadius(10)
 
    }
}

#Preview {
    SearchView(searchText: .constant("asd"))
}
