//
//  ProductView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct ProductView: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .navigationTitle("Title")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomNavButton(image: "arrow.backward" , action: {
            presentationMode.wrappedValue.dismiss()
        }))
        .navigationBarItems(trailing: CustomNavButton(image: "heart" , action: {
            // save/ unsave liked
        }))
        .padding()
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
