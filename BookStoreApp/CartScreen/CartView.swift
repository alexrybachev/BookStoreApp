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
    
    @State private var favoriteBooks: [FireBook]?
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Likes")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ScrollView {
                        if !user.userIsAuthorized {
                            Text("User Isn't Authorized")
                        } else if let favoriteBooks = favoriteBooks {
                            LazyVGrid(columns: columns) {
                                ForEach(favoriteBooks, id: \.self) { book in
                                    NavigationLink(destination: ProductView(keyBook: book.name, iaBook: book.iaBook, authorName: book.authorName)) {
                                        RecentBook(title: book.name,
                                                   author: book.authorName,
                                                   image: book.id)
                                    }
                                }
                            }
                            .padding(.horizontal, 5)
                        } else {
                            Text("No favorite books")
                        }
                    }
                    
                }
                
            }
            
        }
        .onAppear {
            if user.userIsAuthorized {
                favoriteBooks = user.getBookArray(isFav: true)
            } else {
                print("User wasn't logined")
            }
        }
    }
    
}

//#Preview {
//    CartView()
//}
