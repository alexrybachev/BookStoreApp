//
//  ContentView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    @ObservedObject var data: CoreData
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: viewModel, data: data)
                .tabItem {
                    Label("Home", image: selectedTab == 0 ? "homeActive" : "homeInactive")
                }
                .tag(0)
            
            CategoriesView(viewModel: viewModel)
                .tabItem {
                    Label("Categories", image: selectedTab == 1 ? "categoryActive" : "categoryInactive")
                }
                .tag(1)
            
            CartView()
                .tabItem {
                    Label("Likes", image: selectedTab == 2 ? "likesActive" : "likesInactive")
                        .foregroundStyle(.red)
                        .tint(.red)
                        .background(.red)
                        .accentColor(.blue)
                }
                .tag(2)
            
            AccountView()
                .tabItem {
                    Label("Account", image: selectedTab == 3 ? "accountActive" : "accountInactive")
                }
                .tag(3)
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView(viewModel: BookAppViewModel(), data: CoreData())
}
