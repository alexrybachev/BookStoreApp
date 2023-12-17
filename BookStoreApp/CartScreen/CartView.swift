//
//  CartView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack {
                        Text("Likes")
                        //                .font(.system(size: 20, weight: .heavy))
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        if user.userIsAuthorized {
                            Text("User Is Authorized: \(user.getListArray().joined(separator: ", "))")
                        } else {
                            Text("User Isn't Authorized")
                        }
                        
                        Spacer()
                    }
                }
                
            }
            
        }
        .onAppear {
            user.fireBaseRead()
        }
    }
    
}

#Preview {
    CartView()
}
