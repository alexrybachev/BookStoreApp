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
            ZStack {
                Image(.books)
                    .offset(x: -20, y: -180)
                    .scaledToFill()
//                    .containerRelativeFrame(.vertical) {width, axis in
//                        width * 0.4
//                    }
                Image(.logo)
                    .offset(y: 50)
            }
            
            
            Text("Read more and stress less with our online book shopping app. Shop from anywhere you are and discover titles that you love. Happy reading!")
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
            
            ButtonNextView(currentTab: $currentTab)
        }
        .padding()
    }
}

#Preview {
    WelcomeView(currentTab: .constant(0))
}
