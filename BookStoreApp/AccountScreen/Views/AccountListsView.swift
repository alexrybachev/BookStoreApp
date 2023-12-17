//
//  AccountListsView.swift
//  BookStoreApp
//
//  Created by Андрей Бородкин on 14.12.2023.
//

import SwiftUI
import FirebaseDatabase

struct AccountListsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: User
    
    @State private var displayedListArray: [String] = []
    @State private var newName = ""
    @State private var showModal = false
    
    // MARK: - ViewBuilder items
  
    
    // MARK: - View Body
    
    var body: some View {
        NavigationView{
            VStack(spacing: 16) {
                AccountListNavigationBarView(title: "Lists", buttonAction: self.addButtonAction, dismiss: self._dismiss)
                
                if !displayedListArray.isEmpty {
                    ForEach(0..<displayedListArray.count, id: \.self) { index in
                        
                        NavigationLink {
                            AccountSelectedListView(listName: displayedListArray[index], listIndex: index)
                        } label: {
                            AccountButton(displayText: displayedListArray[index])
                                .foregroundColor(.primary)
                        }

                    }
            } else {
                Text("Plz create list")
            }
                Spacer()
            }
            .onAppear(){
                if displayedListArray.isEmpty {
                    user.fireBaseRead()
                    displayedListArray = user.getListArray()
                    }
                }

            .alert("New List", isPresented: $showModal) {
                TextField("Enter new list name", text: $newName)
                Button("Create list", action: createNewList)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func addButtonAction() {
        showModal.toggle()
    }
    
    func createNewList() {
        displayedListArray.append(newName)
        
        user.fireBaseWrite(newList: newName)
        
        newName = ""
    }
}

#Preview {
    AccountListsView()
}
