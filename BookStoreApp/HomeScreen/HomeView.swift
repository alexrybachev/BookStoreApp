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
        NavigationView {
            VStack {
                Text("Hello, World!")
                
                Button("true") {
                    isOnboarding = true
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink {
                    AccountView()
                } label: {
                    
                    Text("Go to account View")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
