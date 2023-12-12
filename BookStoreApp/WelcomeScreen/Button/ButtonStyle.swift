//
//  ButtonStyle.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
        //.fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.top, 20)
    }
}

extension View {
    func customButton() -> some View {
        modifier(CustomButtonModifier())
    }
}
