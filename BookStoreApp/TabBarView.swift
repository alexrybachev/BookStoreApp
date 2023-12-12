//
//  ContentView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Image(selectedTab == 0 ? "homeActive" : "homeInactive")
                }
                .tag(0)
            
            CategoriesView()
                .tabItem {
                    Image(selectedTab == 1 ? "categoryActive" : "categoryInactive")
                }
                .tag(1)
            
            CartView()
                .tabItem {
                    Image(selectedTab == 2 ? "likesActive" : "likesInactive")
                }
                .tag(2)
            
            AccountView()
                .tabItem {
                    Image(selectedTab == 3 ? "accountActive" : "accountInactive")
                }
                .tag(3)
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView(viewModel: BookAppViewModel())
}
