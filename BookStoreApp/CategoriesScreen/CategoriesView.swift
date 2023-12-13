//
//  CategoriesView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    @State private var searchText = ""
    @State private var isFiltered = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    let image = "category_pic"
    
    //    let categories = MockDataProductView.categories
    let categoriesList = CategoryList.categories
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    SearchTFView(searchText: searchText)
                        .padding(.leading, 20)
                    Button {
                        // action
                        print("tap button")
                        isFiltered.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .rotationEffect(.degrees(isFiltered ? 0 : 180))
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
                
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                            ForEach(isFiltered 
                                    ? categoriesList.sorted(by: <)
                                    : categoriesList.sorted(by: >), id: \.self) { category in
                                NavigationLink(destination: CategoryDetailsView(viewModel: viewModel, category: category)) {
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
}

#Preview {
    CategoriesView(viewModel: BookAppViewModel())
}
