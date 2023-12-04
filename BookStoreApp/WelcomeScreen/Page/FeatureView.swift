//
//  FeatureView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

struct FeatureView: View {
    @Binding var currentTab: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 100)
            
            FeatureCard(iconName: "person.2.crop.square.stack.fill",
                        description: "A multiline description about a feature paired with the image.")
            
            FeatureCard(iconName: "quote.bubble.fill", description: "А large number of books")
            Spacer()
            
            ButtonNextView(currentTab: $currentTab)
        }
        .padding()
    }
}

#Preview {
    FeatureView(currentTab: .constant(1))
}
