//
//  PictureTextView.swift
//  BookStoreApp
//
//  Created by Alex on 03.12.2023.
//

import SwiftUI

struct PictureTextView: View {

    @State private var showLoginAlert = false
    @State private var showSuccessAlert = false
    var isUserLoggedIn = true // vm

    let openWebViewAction: ()->()
    let autor: String = "Oscar Wilde"
    let category: String = "Classics"
    let rating: String = "4.11/5"
    let alertTitletoRead = "Добавили!"
    let alertTitle = "Уважаемый"
    let alertMessage = "Войдите в аккаунт или зарегистрируйтесь"
    let alertLeftText = "Лаааадно"
    let alertRightText = "Не хочу!"

    var body: some View {
        VStack {
            HStack (alignment: .bottom , spacing: 22, content: {
                Image("book_cover")
                VStack (alignment: .leading, spacing: 8, content: {
                    Text("Author: ")
                        .font(.system(size: 14)) +
                    Text(autor)
                        .font(.system(size: 14, weight: .bold))
                    Text("Category: ")
                        .font(.system(size: 14)) +
                    Text(category)
                        .font(.system(size: 14, weight: .bold))
                    Text("Rating: ")
                        .font(.system(size: 14)) +
                    Text(rating)
                        .font(.system(size: 14, weight: .bold))
                    PictureTextViewCustomButton(title: "Add to list", color: .gray) {
                        !isUserLoggedIn ? showGoToLoginAlert() : showAddedToListAlert()
                    }
                    .padding(.top, 21)
                    PictureTextViewCustomButton(title: "Read", color: .black) {
                        !isUserLoggedIn ? showGoToLoginAlert() : openWebViewAction()
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
            })
        }
    }

    private func goToLoginTapped() {
        print("User tappet go to login")
    }

    private func showGoToLoginAlert() {
        showLoginAlert = true
    }

    private func showAddedToListAlert() {
        showSuccessAlert = true
        addToList()
    }

    private func addToList() {
        // request to vm
        // after - show success eee!
        print("addToList")
    }
}

#Preview {
    PictureTextView {}
}

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
