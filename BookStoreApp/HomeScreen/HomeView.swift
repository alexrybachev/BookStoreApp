//
//  HomeView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                SearchView(searchText: $search, viewModel: viewModel)
                
                if search.isEmpty {
                    MainView(viewModel: viewModel)
                } else {
                    EmptyViewSearch(query: $search, viewModel: viewModel)
                }
            }
            .padding()
            .background(.backgroundApp)
        }
        .task {
            withAnimation{
                viewModel.fetchTrendsBooks()
            }
        }
    }
    
    func clearSearchList() {
        viewModel.searchBooksList = []
    }

}

#Preview {
    HomeView(viewModel: BookAppViewModel())
}
