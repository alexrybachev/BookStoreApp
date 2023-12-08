//
//  ContentView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", image: "home")
                }
            CategoriesView()
                .tabItem {
                    Label("Categories", image: "categories")
                }
            CartView()
                .tabItem {
                    Label("Likes", image: "likes")
                }
            AccountView()
                .tabItem {
                    Label("Account", image: "account")
                }
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView()
}
