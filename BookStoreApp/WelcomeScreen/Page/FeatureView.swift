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
            
            Image(.iPhoneFeaturedView)
                .resizable()
                .scaledToFit()

            Spacer()
            
            FeatureCard(iconName: "quote.bubble.fill", description: "An incredible amount of books")
   
            ButtonNextView(currentTab: $currentTab)
        }
        .padding()
    }
}

#Preview {
    FeatureView(currentTab: .constant(1))
}
