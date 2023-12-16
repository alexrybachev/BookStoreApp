//
//  User.swift
//  BookStoreApp
//
//  Created by Андрей Бородкин on 14.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

var userDataModel: [String: Any] = [
    "email": "userMail",
    "lists" : [
        "list_id1": [
            "name": "listName",
            "books": [
                "book_id1" : [
                    "title": "LordOfTHeRings",
                    "code": "abrakadabra"
                ]
            ]
        ]
    ]
]


class User: ObservableObject {
    @Published var userIsAuthorized = false
    
    private var firebaseAuth = Auth.auth()
    private let database = Database.database(url: "https://bookstoreapp-marathon-x-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    private (set) var userID: String?
    private (set) var email: String?
    private (set) var userData: [String: Any]?
    
    
   
    
    // MARK: - FB Auth methods
    
    func registerUser(email: String, userName: String, password: String) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                guard let result = authResult else {return}
                let id = result.user.uid
                
                self.fillInUserDetails(email: email, userID: id)
                self.fireBaseWrite(newUser: email, name: userName)
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                guard let result = authResult else {return}
                
                let id = result.user.uid
                self.fillInUserDetails(email: email, userID: id)
                
                self.fireBaseRead()
            }
        }
    }
    
    func logoutUser() {
        do {
          try firebaseAuth.signOut()
            userIsAuthorized = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    
    // MARK: - FB Database methods
    
    func fireBaseWrite(newUser email: String, name: String) {
        let newUserData = [
            K.EMAIL: email,
            K.USER_NAME: name
        ]
        
        self.userData = newUserData
        fbWrite()
    }
    
    func fireBaseWrite(newList listName: String) {
        
        guard var currentUserData = self.userData else {return}
            
            print("value from userData ", currentUserData)
            
            var listId = 1
            
        
        if var currentListList = currentUserData[K.LISTS] as? [String: Any]{
            var count = 0
            for (_, _) in currentListList {
                count += 1
            }
            
            listId = count + 1
            
            currentListList["list_id\(listId)"] = [
                "name": listName
            ]
            
            currentUserData[K.LISTS] = currentListList
        } else {
                        
            currentUserData[K.LISTS] = [
                "list_id\(listId)" : [
                    "name": listName
                ]
            ]
        }
            
        self.userData = currentUserData
        
        fbWrite()
       
    }
    func fireBaseWrite(addToFavorite listName: String, bookName: String, bookCode: String) {
        
        guard var currentUserData = self.userData else {return}
        
        guard var favsList = currentUserData[K.FAVS] as? [String: Any] else {
            currentUserData[K.FAVS] = [
                K.FAVS : [
                    "name": K.FAVS
                ]
            ]
            
            self.userData = currentUserData
            fbWrite()
            return
        }
        
        if var selectedList = favsList[K.FAVS] as? [String: Any] {
            
            var bookId = 1
            
            if var books = selectedList[K.BOOKS] as? [String: Any] {
                var count = 0
                for (_, _) in books {
                    count += 1
                }
                bookId = count + 1
                
                books["book_id\(bookId)"] = [
                    "title": bookName,
                    "code": bookCode
                ]
                
                
                selectedList[K.BOOKS] = books
            } else {
                
                selectedList[K.BOOKS] = [
                    "book_id\(bookId)" : [
                        "title": bookName,
                        "code": bookCode
                    ]
                ]
                
            }
            
            favsList = selectedList
            currentUserData[K.FAVS] = favsList
            self.userData = currentUserData
            fbWrite()
            
        }
    }
    
    func fireBaseWrite(newBook bookName: String, bookCode: String, listIndex: Int) {
        
        guard var currentUserData = self.userData else {return}
                        
            
        if var currentListList = currentUserData[K.LISTS] as? [String: Any]{
            if var selectedList = currentListList["list_id\(listIndex+1)"] as? [String: Any] {
                
                var bookId = 1
                
                if var books = selectedList[K.BOOKS] as? [String: Any] {
                    var count = 0
                    print("selectedList: ", selectedList[K.BOOKS])
                    print("books in selectedList: ", books)
                    for (_, _) in books {
                        count += 1
                    }
                    bookId = count + 1
                    
                    books["book_id\(bookId)"] = [
                        "title": bookName,
                        "code": bookCode
                    ]
                    print("updated books in selectedList: ", books)
                    
                    selectedList[K.BOOKS] = books
                    print("updated selectedList: ", selectedList[K.BOOKS])
                } else {
                    
                    selectedList[K.BOOKS] = [
                        "book_id\(bookId)" : [
                            "title": bookName,
                            "code": bookCode
                        ]
                    ]
                }
                                
                
                currentListList["list_id\(listIndex+1)"] = selectedList
                currentUserData[K.LISTS] = currentListList
                self.userData = currentUserData
                fbWrite()
            }
        }
                        
            
        
       
    }
    
    func fireBaseRead(){
        guard let userID = self.userID else {return}
        
        self.database.child(K.USERS).child(userID).observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any] else {
                return
            }
            self.userData = userData
        }
        
    }
    
    func getListArray() -> [String]{
        
        var tempArray: [String] = []
        if let currentList = self.userData?[K.LISTS] as? [String: Any] {
            
            for (key, value) in currentList {
                if key != K.BOOKS {
                    if case let listItem as  [String: Any] = value {
                        if case let name as String = listItem["name"] {
                            
                            tempArray.append(name)
                        }
                    }
                }
            }
        }
        return tempArray
    }
    
    func getBookArray(for listID: Int, isFav: Bool? = false) -> [FireBook]{
        
        var tempArray: [FireBook] = []
        if let currentList = self.userData?[K.LISTS] as? [String: Any] {
            
            for (key, value) in currentList {
                print("key", key)
                if (key == "list_id\(listID)") || (isFav ?? false && key == K.FAVS) {
                    print ("I got inside")
                    
                    if case let listItem as [String: Any] = value {
                        
                        if case let booksArray as [String: Any] = listItem["books"] {
                            
                            
                            for (_, value) in booksArray {
                                
                                if case let book as [String: String] = value {
                                    
                                    tempArray.append(FireBook(name: book[K.TITLE] ?? "error", id: book[K.CODE] ?? "error"))
                                }
                            }
                        }
                    }
                }
                
            }
        }
        return tempArray
    }
    
    func getUserName() -> String {
        
        guard case let userName = self.userData?[K.USER_NAME] else {return "Error is Error" }
        print("userData", userData)
        print("usrName", userName)
        return ""
    }
    
    func getUserEmail() -> String {
        guard let email = self.email else {return "No luck"}
        
        return email
    }
    
    // MARK: - Helper Methods (private)
    
    private func fbWrite() {
        self.database.child(K.USERS).child(self.userID!).setValue(self.userData) {
            (error: Error?, database: DatabaseReference) in
            if let e = error {
                print("There was a error: \(e)")
            } else {
                print("Data saved successfully")
            }
        }
    }
    
    private func fillInUserDetails(email: String, userID: String) {
         self.userIsAuthorized = true
         self.email = email
         self.userID = userID
     }
     
     private func clearUserDetails() {
         self.userIsAuthorized = false
         self.userID = nil
         self.email = nil
         self.userID = nil
         self.userData = nil
     }
}
