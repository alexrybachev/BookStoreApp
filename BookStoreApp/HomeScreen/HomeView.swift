//
//  HomeView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    @ObservedObject var data: CoreData
    
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                SearchView(searchText: $search, viewModel: viewModel)
                
                if search.isEmpty {
                    MainView(viewModel: viewModel, coreData: data)
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

}

#Preview {
    HomeView(viewModel: BookAppViewModel(), data: CoreData())
}
