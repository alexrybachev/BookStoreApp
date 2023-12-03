//
//  ProductView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct ProductView: View {

    @Environment(\.presentationMode) var presentationMode

    let title = "Title"
    let backButtonIbage = "arrow.backward"
    let likeButtonImage = "heart"
    let bookNameText = "The Picture of Dorian Gray"
    let descriptionText = "Description:"
    let fullDescriptionText = """
    Oscar Wilde’s only novel is the dreamlike story of a young man who sells his soul for eternal youth and beauty. In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century England. Combining elements of the Gothic horror novel and decadent French fiction, the book centers on a striking premise: As Dorian Gray sinks into a life of crime and gross sensuality, his body retains perfect youth and vigor while his recently painted portrait grows day by day into a hideous record of evil, which he must keep hidden from the world. For over a century, this mesmerizing tale of horror and suspense has enjoyed wide popularity. It ranks as one of Wilde's most important creations and among the classic achievements of its kind.
        Oscar Wilde’s only novel is the dreamlike story of a young man who sells his soul for eternal youth and beauty. In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century England. Combining elements of the Gothic horror novel and decadent French fiction, the book centers on a striking premise: As Dorian Gray sinks into a life of crime and gross sensuality, his body retains perfect youth and vigor while his recently painted portrait grows day by day into a hideous record of evil, which he must keep hidden from the world. For over a century, this mesmerizing tale of horror and suspense has enjoyed wide popularity. It ranks as one of Wilde's most important creations and among the classic achievements of its kind.
    """

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            VStack {
                Text(bookNameText)
                    .font(.system(size: 24, weight: .semibold))
                PictureTextView()
                    .padding(.top, 16)
                Text(descriptionText)
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ScrollView {
                    Text(fullDescriptionText)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 14)
                }
            }
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomNavButton(image: backButtonIbage, action: {
                presentationMode.wrappedValue.dismiss()
            }))
            .navigationBarItems(trailing: CustomNavButton(image: likeButtonImage, action: {
                // save/ unsave liked
            }))
            .padding()
        }
    }
}

#Preview {
    ProductView()
}

struct CustomNavButton: View {

    @State var changeLikedState: Bool = false

    let image: String
    let action: ()->()

    var body: some View {
        Button(action: {
            if image == "heart" { changeLikedState.toggle() }
            action()
        }) {
            Image(systemName: checkImage())
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(.black)
        }
    }

    func checkImage()-> String {
        image == "heart" ? (changeLikedState ? ("heart.fill") : ("heart")): (image)
    }
}
