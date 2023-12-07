//
//  CategoriesView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            Text("Categories view will be soon")
        }
        .searchable(text: $searchText, prompt: "Search title/author/ISBN no")
    }
}

#Preview {
    CategoriesView()
}
