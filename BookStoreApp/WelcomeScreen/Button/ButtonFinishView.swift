//
//  ButtonFinishView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

struct ButtonFinishView: View {
  
    @EnvironmentObject var viewModel: BookAppViewModel
    
    var body: some View {
        Button {
            withAnimation {
                viewModel.isOnboarding = false
            }
        } label: {
            Text("Finish")
                .frame(maxWidth: .infinity)
        }
        .customButton()
        //.buttonStyle(.borderedProminent)
    }
}

#Preview {
    ButtonFinishView()
}
