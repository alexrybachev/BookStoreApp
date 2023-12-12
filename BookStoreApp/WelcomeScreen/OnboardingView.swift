//
//  OnboardingView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 04.12.2023.
//

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct OnboardingView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    @State private var currentTab = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom)
            
            TabView(selection: $currentTab,
                    content: {
                WelcomeView(currentTab: $currentTab)
                    .tag(0)
                FeatureView(currentTab: $currentTab)
                    .tag(1)
                FinishView(viewModel: viewModel)
                    .tag(2)
            })
        }
        .tabViewStyle(.page)
        .foregroundStyle(.white)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView(viewModel: BookAppViewModel())
}
