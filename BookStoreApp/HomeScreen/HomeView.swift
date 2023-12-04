//
//  HomeView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("true") {
            isOnboarding = true
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    HomeView()
}
