//
//  HomeView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                SearchView(searchText: $search)
                if search.isEmpty {
                    MainView()
                } else {
                    EmptyViewSearch(query: $search)
                }
            }
            .padding()
            .background(.backgroundApp)
            
        }

    }
}

#Preview {
    HomeView()
}
