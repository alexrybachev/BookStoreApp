//
//  AccountView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

// Registered Test User email: 1@2.ru
// Registered Test User password: 123456

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    
    // MARK: - View params
    @State var email = ""
    @State var password = ""
    @State var userIsRegistered = false {
        didSet{
            if userIsRegistered == false {
                email = ""
                password = ""
            }
        }
    }
    
    @State var firebaseAuth = Auth.auth()
    
    // MARK: - ViewBuilder items
    @ViewBuilder private var tempAuthForm: some View {
        VStack{
            Form{
                Section ("Enter E-mail"){
                    TextField("E-mail", text: $email)
                }
                Section ("Enter password"){
                    TextField("Password", text: $password)
                }
            }
            .frame(height: 200)
        }
    }
    
    @ViewBuilder private var tempSubmitButtons: some View {
        HStack{
            Spacer()
            Button {
                userIsRegistered ? logoutUser() : loginUser()
            }
        label:{
            Text(userIsRegistered ? "Log out" : "Login")
                .font(Font.custom("Open Sans", size: 18))
                .fontWeight(.bold)
        }
            Spacer()
            Button {
                registerUser()
            } label: {
                Text("Register")
                    .font(Font.custom("Open Sans", size: 18))
                    .fontWeight(.bold)
            }
            Spacer()

        }
        .frame(width: 320, height: 36)
        .padding()
        .background(Color(red: 0.0, green: 0.0, blue: 0.5).opacity(0.1))
        .cornerRadius(5)
    }
    
    // MARK: - View Body
    
    var body: some View {
        NavigationView {
            VStack {
                Image("account_circle")
                    .frame(width: 120, height: 120)
                    .padding()
                HStack{
                    Text("Name :")
                        .font(Font.custom("Open Sans", size: 14))
                    Spacer()
                    Text(userIsRegistered ? email : "John Doe")
                        .font(Font.custom("Open Sans", size: 16))
                        .fontWeight(.bold)
                    Spacer()
                }
                .frame(width: 320, height: 36)
                .padding()
                .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                .cornerRadius(5)
                .padding(.bottom)
               
                NavigationLink {
                    AccountListsView()
                } label: {
                    AccountButton(displayText: "My Lists")
                        .foregroundColor(.primary)
                }

                
                Spacer()
                
                tempAuthForm
                
                tempSubmitButtons
                
            }
            .navigationTitle (
                Text("Account")
                    .font(Font.custom("Open Sans", size: 16))
                    .fontWeight(.bold))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Methods
    
    func registerUser() {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                userIsRegistered = true
            }
        }
    }
    
    func loginUser() {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                userIsRegistered = true
            }
        }
    }
    
    func logoutUser() {
        do {
          try firebaseAuth.signOut()
            userIsRegistered = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    AccountView()
}
