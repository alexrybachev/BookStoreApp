//
//  CategoriesView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct CategoriesView: View {

    @State private var searchText = ""
    let image = "category_pic"

    let categories = MockDataProductView.categories

    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchTFView(searchText: searchText)
                        .padding(.leading, 20)
                    Button {
                        // action
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.black)
                            .frame(width: 56, height: 56)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(4)
                            .padding(.trailing, 20)
                    }
                }.padding(.top, 32)
                HStack {
                    Text("Categories")
                        .font(.system(size: 20, weight: .heavy))
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 32)
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(categories, id: \.self) { category in
                            NavigationLink(destination: CategoryDetailsView(books: MockDataProductView.sampleBooks)) {
                                CategoryCell(category: category, image: image)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CategoriesView()
}
