//
//  WelcomeView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var currentTab: Int
    
    var body: some View {
        VStack {
            VStack {
                Image(.books)
                    .scaledToFit()
             //      .offset(x: -20, y: -180)
//                    .containerRelativeFrame(.vertical) {width, axis in
//                        width * 0.4
//                    }
                Image(.logo)
                    .offset(y: -100)
            }
            .frame(width: 250, height: 250)
            .scaledToFill()
            Spacer()
            FeatureCard(iconName: "person.2.crop.square.stack.fill",
                        description: "Read more and stress less with our online book shopping app. Shop from anywhere you are and discover titles that you love. Happy reading!")
//            Text("Read more and stress less with our online book shopping app. Shop from anywhere you are and discover titles that you love. Happy reading!")
//                .padding(.horizontal, 20)
//                .multilineTextAlignment(.center)
            
            ButtonNextView(currentTab: $currentTab)
        }
        .padding()
    }
}

#Preview {
    WelcomeView(currentTab: .constant(0))
}
