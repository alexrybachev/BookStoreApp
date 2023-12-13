//
//  SearchTFView.swift
//  BookStoreApp
//
//  Created by Alex on 10.12.2023.
//

import SwiftUI

struct SearchTFView: View {

    @State var searchText: String

    var body: some View {
        TextField("Search books by title/author", text: $searchText, onEditingChanged: { isEditing in
            // action
        }, onCommit: {
            print("onCommit")
        })
        .foregroundColor(.black)
        .frame(height: 56)
        .multilineTextAlignment(.center)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(4)
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                Spacer()
            }
        )
    }
}

#Preview {
    SearchTFView(searchText: "text")
}

