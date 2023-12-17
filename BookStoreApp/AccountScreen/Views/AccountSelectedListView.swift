//
//  AccountSelectedListView.swift
//  BookStoreApp
//
//  Created by Андрей Бородкин on 14.12.2023.
//

import SwiftUI
import FirebaseDatabase


struct FireBook: Hashable {
    let name: String
    let id: String
    let iaBook: String
    let authorName: String
}

struct AccountSelectedListView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: User
    
    @State private var displayedBooksArray: [FireBook]?
    
    var newName = ""
    var newCode = "1111"
    var newIaBook = ""
    var newAuthorBook = "1111"
    
    var listName: String
    var listIndex: Int
    
    var body: some View {
        NavigationView{
            VStack{
                
                AccountListNavigationBarView(title: listName, buttonAction: self.addButtonAction, dismiss: self._dismiss)
                
                VStack (spacing: 16){
                    if let favoriteBooks = displayedBooksArray {
                        ForEach(favoriteBooks, id: \.self) { book in
                            NavigationLink(destination: ProductView(keyBook: book.name, iaBook: book.iaBook, authorName: book.authorName)) {
                                RecentBook(title: book.name,
                                           author: book.authorName,
                                           image: book.id)
                            }
                        }
                        .padding(.horizontal, 5)
                    } else {
                        Text("No favorite books")
                    }
                }
                
                Spacer()
            }
            .onAppear(){
                guard let displayedBooksArray = displayedBooksArray else { return }
                user.fireBaseRead()
                self.displayedBooksArray = user.getBookArray(for: listIndex+1)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func addButtonAction() {
        addNewBook()
    }
    
    func addNewBook() {
        guard var unwrappedArray = displayedBooksArray else { return }
        unwrappedArray.append(FireBook(name: newName, id: newCode, iaBook: newIaBook, authorName: newAuthorBook))
        displayedBooksArray = unwrappedArray
        user.fireBaseWrite(newBook: newName, bookCode: newCode, listIndex: listIndex, iaBook: newIaBook, authorName: newAuthorBook)
    }
}

//#Preview {
//    AccountSelectedListView(
//        displayedBooksArray: [FireBook(name: "name", id: "id")],
//                            listName: "listName",
//                            listIndex: 10
//    )
//}
