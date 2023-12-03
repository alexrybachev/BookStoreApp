//
//  PictureTextView.swift
//  BookStoreApp
//
//  Created by Alex on 03.12.2023.
//

import SwiftUI

struct PictureTextView: View {
    
    let autor: String = "Oscar Wilde"
    let category: String = "Classics"
    let rating: String = "4.11/5"

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
                    PictureTextViewCustomButton(title: "Add to list", color: .gray)
                        .padding(.top, 21)
                    PictureTextViewCustomButton(title: "Read", color: .black)
                        .padding(.top, 5)
                })
            })
        }
    }
}

#Preview {
    PictureTextView()
}


struct PictureTextViewCustomButton: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .foregroundStyle(.white)
            .font(.system(size: 14, weight: .medium))
            .frame(width: 161, height: 40)
            .background(color)
            .clipShape(.rect(cornerRadius: 4))
            .shadow(color: .black.opacity(0.4), radius: 5, y: 2)
    }
}
