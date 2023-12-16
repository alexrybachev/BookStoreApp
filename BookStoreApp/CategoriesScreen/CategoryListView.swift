//
//  CategoryListView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 16.12.2023.
//

import SwiftUI

struct CategoryListView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    @Binding var isFiltered: Bool
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    let image = "category_pic"
    
    //    let categories = MockDataProductView.categories
    let categoriesList = CategoryList.categories
    
    var body: some View {
        HStack {
            Text("Categories")
//                .font(.system(size: 20, weight: .heavy))
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
//        .padding(.leading, 20)
//        .padding(.top, 32)
        
        
        ScrollView(showsIndicators: false) {
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
    }
}

//#Preview {
//    CategoryListView(viewModel: BookAppViewModel(), isFiltered: false)
//}
