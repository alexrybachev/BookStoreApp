//
//  ButtonNextView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

struct ButtonNextView: View {
    @Binding var currentTab: Int
    
    var body: some View {
        Button("Next") {
            withAnimation {
                currentTab += 1
            }
        }
        .customButton()
    }
}

#Preview {
    ButtonNextView(currentTab: .constant(0))
}
