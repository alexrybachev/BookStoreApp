//
//  ButtonFinishView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

struct ButtonFinishView: View {
  
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        Button("Finish") {
            withAnimation {
                isOnboarding = false
            }
        }
        .customButton()
    }
}

#Preview {
    ButtonFinishView()
}
