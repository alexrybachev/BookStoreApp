//
//  CategoriesView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    @EnvironmentObject var viewModel: BookAppViewModel
    @State private var isFiltered = false
    @State private var searchText = ""
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack {
                    
                    SearchView(searchText: $searchText,
                               focusField: $isFocused)
                    
                    if isFocused {
                        Button {
                            viewModel.fetchSearchBooks(query: searchText)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(viewModel.isLightTheme ? .black : .gray)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                        }
                    } else {
                        Button {
                            isFiltered.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .rotationEffect(.degrees(isFiltered ? 0 : 180))
                                .foregroundColor(viewModel.isLightTheme ? .black : .gray)
                                .frame(width: 56, height: 56)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                        }
                    }
                }
                
                if searchText.isEmpty {
                    CategoryListView(isFiltered: $isFiltered)
                } else {
                    EmptyViewSearch(query: $searchText)
                }
            }
            .padding()
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

#Preview {
    CategoriesView()
}
