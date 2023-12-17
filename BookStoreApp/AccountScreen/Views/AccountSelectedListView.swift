//
//  AccountSelectedListView.swift
//  BookStoreApp
//
//  Created by Андрей Бородкин on 14.12.2023.
//

import SwiftUI
import FirebaseDatabase


struct FireBook: Hashable {
    var name: String
    var id: String
}

struct AccountSelectedListView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: User
    
    @State private var displayedBooksArray: [FireBook] = []
    @State private var newName = ""
    @State private var newCode = "1111"
    @State private var showModal = false
    
    var listName: String
    var listIndex: Int
    
    var body: some View {
        NavigationView{
            VStack{
                
                AccountListNavigationBarView(title: listName, buttonAction: self.addButtonAction, dismiss: self._dismiss)
                
                VStack (spacing: 16){
                    if !displayedBooksArray.isEmpty {
                        
                        ForEach(displayedBooksArray, id: \.self) {book in
                            AccountButton(displayText: book.name)
                        }
                    } else {
                        Text("Please add books to your list")
                    }
                }
                
                Spacer()
            }
            .onAppear(){
                
                if displayedBooksArray.isEmpty {
                    user.fireBaseRead()
                    displayedBooksArray = user.getBookArray(for: listIndex+1)
                }
                
            }
            .alert("New Book", isPresented: $showModal) {
                TextField("Enter new list name", text: $newName)
                Button("Create list", action: addNewBook)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func addButtonAction() {
        showModal.toggle()
    }
    
    func addNewBook() {
        displayedBooksArray.append(FireBook(name: newName, id: newCode))
        user.fireBaseWrite(newBook: newName, bookCode: newCode, listIndex: listIndex)
        newName = ""
    }
}

//#Preview {
//    AccountSelectedListView(
//        displayedBooksArray: [FireBook(name: "name", id: "id")],
//                            listName: "listName",
//                            listIndex: 10
//    )
//}
