//
//  SkeletonRectItem.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.12.2023.
//

import SwiftUI


struct SkeletonRectItem: View {

    @State var startPoint = UnitPoint.topLeading
    @State var endPoint = UnitPoint.bottomTrailing

    var gradient = [Color.gray, Color.white.opacity(0.8)]

    var gradientFill: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: self.gradient),
            startPoint: self.startPoint,
            endPoint: self.endPoint
        )
    }
    
    var body: some View {
        Rectangle()
            .fill(gradientFill)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                    self.startPoint = UnitPoint(x: 0.2, y: 0.5)
                }
            }
    }
}

struct SkeletonCapsuleItem: View {
    
    @State var startPoint = UnitPoint.topLeading
    @State var endPoint = UnitPoint.bottomTrailing

    var gradient = [Color.gray, Color.white.opacity(0.8)]

    var gradientFill: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: self.gradient),
            startPoint: self.startPoint,
            endPoint: self.endPoint
        )
    }
    
    var body: some View {
        Capsule()
            .fill(gradientFill)
            .frame(height: 10)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                    self.startPoint = UnitPoint(x: 0.2, y: 0.5)
                }
            }
        
    }
}

#Preview {
    SkeletonRectItem()
}
