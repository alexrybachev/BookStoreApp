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
        Button {
            withAnimation {
                currentTab += 1
            }
        }label: {
            Text("Next")
                .frame(maxWidth: .infinity)
        }
        .customButton()
    }
}

#Preview {
    ButtonNextView(currentTab: .constant(0))
}
