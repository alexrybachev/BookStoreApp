//
//  ContentView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var viewModel: BookAppViewModel
    @EnvironmentObject var coreData: CoreData
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", image: selectedTab == 0 ? "homeActive" : "homeInactive")
                }
                .tag(0)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", image: selectedTab == 1 ? "categoryActive" : "categoryInactive")
                }
                .tag(1)
            
            CartView()
                .tabItem {
                    Label("Likes", image: selectedTab == 2 ? "likesActive" : "likesInactive")
                }
                .tag(2)
            
            AccountView()
                .tabItem {
                    Label("Account", image: selectedTab == 3 ? "accountActive" : "accountInactive")
                }
                .tag(3)
        }
        .preferredColorScheme(viewModel.isLightTheme ? .light : .dark)
        .tint(viewModel.isLightTheme ? .black : .white)
    }
}

#Preview {
    TabBarView()
}
