//
//  FinishView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

struct FinishView: View {
    var body: some View {
        VStack {
            Image(.iPhoneFinishView)
                .resizable()
                .scaledToFill()

            Spacer()
            
            FeatureCard(iconName: "person.2.crop.square.stack.fill",
                        description: "A complete description of the book with information about the author, genre and rating of the book.")
            ButtonFinishView()
        }
        .padding()
    }
}

#Preview {
    FinishView()
}
