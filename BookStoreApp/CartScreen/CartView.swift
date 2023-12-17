//
//  CartView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var user: User
    @EnvironmentObject var coreData: CoreData
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                //                VStack {
                
                VStack {
                    Text("Likes")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    /*
                     if user.userIsAuthorized {
                     Text("User Is Authorized: \(user.getListArray().joined(separator: ", "))")
                     } else {
                     Text("User Isn't Authorized")
                     }
                     
                     Spacer()
                     */
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(coreData.savedRecentBooks.reversed(), id: \.self) { book in
                                RecentBook(title: book.titleName ?? "",
                                           author: book.author ?? "",
                                           image: book.coverId ?? "")
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    
                }
                //                }
                
            }
            
        }
        .onAppear {
            if user.userIsAuthorized {
                print("User was logined")
                user.fireBaseRead()
                print("getListArray: \(user.getBookArray(isFav: true))")
            } else {
                print("User wasn't logined")
            }
            coreData.fetchRecentBooks()
        }
    }
    
}

#Preview {
    CartView()
}
