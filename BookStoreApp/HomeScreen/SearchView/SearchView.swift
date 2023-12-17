//
//  SearchView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var viewModel: BookAppViewModel
    @Binding var searchText: String
   
    var focusField: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(viewModel.isLightTheme ? .black : .gray)
                    .padding(10)
                
                TextField("Search books by title/author", text: $searchText)
                    .onTapGesture {
                        focusField.wrappedValue = true
                    }
                    .foregroundColor(viewModel.isLightTheme ? .black : .gray)
                    .frame(height: 56)
                    .multilineTextAlignment(.center)
                    .focused(focusField)
                    .tint(viewModel.isLightTheme ? .black : .gray)
                
                Button {
                    searchText = ""
                    viewModel.searchBooksList = []
                    focusField.wrappedValue = false
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .opacity(searchText.isEmpty ? 0 : 0.8)
                        .foregroundStyle(viewModel.isLightTheme ? .black : .gray)
                }
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(4)
            .onSubmit {
                focusField.wrappedValue = false
                viewModel.fetchSearchBooks(query: searchText)
            }
            
        }
//        .animation(.bouncy, value: focusField.wrappedValue)
    }
}
