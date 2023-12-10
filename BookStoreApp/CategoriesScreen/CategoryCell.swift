//
//  CategoryCell.swift
//  BookStoreApp
//
//  Created by Alex on 10.12.2023.
//

import SwiftUI

struct CategoryCell: View {
    let category: String
    let image: String

    var backgroundImage: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 150)
                .clipped()

        }
        .background(Color.black)
    }

    var body: some View {
        ZStack {
            backgroundImage.opacity(0.6)
            VStack {
                Spacer()
                Text(category)
                    .font(.system(size: 30, weight: .heavy))
                    .scaledToFit()
                    .minimumScaleFactor(0.2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
        }
        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 120)
    }
}
