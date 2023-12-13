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
                
                SearchView(searchText: $search)
                
                if search.isEmpty {
                    MainView(viewModel: viewModel)
                } else {
                    EmptyViewSearch(query: $search)
                }
            }
            .padding()
            .background(.backgroundApp)
        }
        .task {
            viewModel.fetchTrendsBooks()
        }
    }

}

#Preview {
    HomeView(viewModel: BookAppViewModel())
}
