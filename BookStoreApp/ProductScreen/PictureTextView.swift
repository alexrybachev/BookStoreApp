//
//  PictureTextView.swift
//  BookStoreApp
//
//  Created by Alex on 03.12.2023.
//

import SwiftUI
import Kingfisher

struct PictureTextView: View {

    @EnvironmentObject var user: User
    
    @State private var showLoginAlert = false
    @State private var showSuccessAlert = false
    @State private var isDetailViewActive = false

    let titleBook: String
    let coverId: String
    let authorName: String
    let category: String
    let rating: String
    let keyBook: String
    let iaBook: String
    

    let openWebViewAction: () -> ()
    let alertTitletoRead = "Добавили!"
    let alertTitle = "Уважаемый"
    let alertMessage = "Войдите в аккаунт или зарегистрируйтесь"
    let alertLeftText = "Лаааадно"
    let alertRightText = "Не хочу!"

    var body: some View {
        VStack {
            HStack (alignment: .bottom , spacing: 22) {
                
                KFImage(URL(string: Kf.path(value: coverId, path: .id)))
                    .placeholder({
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(2.0, anchor: .center)
                    })
                    .resizable()
                    .scaledToFit()
                
//                Image("book_cover")
                VStack (alignment: .leading, spacing: 8, content: {
                    Text("Author: ")
                        .font(.system(size: 14)) +
                    Text(authorName)
                        .font(.system(size: 14, weight: .bold))
                    Text("Category: ")
                        .font(.system(size: 14)) +
                    Text(category)
                        .font(.system(size: 14, weight: .bold))
                    Text("Rating: ")
                        .font(.system(size: 14)) +
                    Text(rating)
                        .font(.system(size: 14, weight: .bold))
                    
                    if user.userIsAuthorized {
                        
                        NavigationLink(
                            destination: AccountListsView(titleBook: titleBook,
                                                          keyBook: keyBook,
                                                          iaBook: iaBook,
                                                          authorName: authorName)
                        ) {
                            PictureTextViewCustomButton(title: "Add to list", color: .gray) {
                                print("tap Add to list")
                            }
                            .disabled(true)
                            .padding(.top, 21)
                        }
                        

                    } else {
                        PictureTextViewCustomButton(title: "Add to list", color: .gray) {
                            showGoToLoginAlert()
                        }
                        .padding(.top, 21)
                    }
                    
                    PictureTextViewCustomButton(title: "Read", color: .black) {
//                        !user.userIsAuthorized ? showGoToLoginAlert() : openWebViewAction()
                        openWebViewAction()
                    }
                    .padding(.top, 5)
                })
                .alert(isPresented: $showLoginAlert) {
                    withAnimation {
                        Alert(
                            title: Text(alertTitle),
                            message: Text(alertMessage),
                            primaryButton: .default(Text(alertLeftText)),
                            secondaryButton: .default(Text(alertRightText), action: {
                                goToLoginTapped()
                            })
                        )
                    }
                }
                .alert(isPresented: $showSuccessAlert) {
                    Alert(title: Text(alertTitletoRead))
                }
            }
            .padding()
        }
    }

    private func goToLoginTapped() {
        print("User tappet go to login")
    }

    private func showGoToLoginAlert() {
        showLoginAlert = true
    }

    private func showAddedToListAlert() {
        print(#function)
        isDetailViewActive = true
    }

//    private func addToList() {
//        // request to vm
//        // after - show success eee!
//        print("addToList")
//
//        isDetailViewActive = true
//    }
}

//#Preview {
//    PictureTextView(
//        coverId: "test",
//        authorName: "authorName",
//        category: "category",
//        rating: "4/5",
//        openWebViewAction: {}
//    )
//}

struct PictureTextViewCustomButton: View {
    let title: String
    let color: Color
    let action: ()->()

    var body: some View {
        Button(title) {
            action()
        }
        .foregroundStyle(.white)
        .font(.system(size: 14, weight: .medium))
        .frame(width: 161, height: 40)
        .background(color)
        .clipShape(.rect(cornerRadius: 4))
        .shadow(color: .black.opacity(0.4), radius: 5, y: 2)
    }
}
