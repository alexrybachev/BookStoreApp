//
//  SkeletonItem.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.12.2023.
//

import SwiftUI

struct SkeletonItem: View {
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.5)
            
            VStack(spacing: 0) {
                
                SkeletonRectItem()
                    .frame(width: 90, height: 120)
                    .padding(.vertical, 10)
        
                ZStack(alignment: .leading) {
                    Color.black
                    
                    infoPlaceholderText
                }
                .frame(height: 92)
            }
        }
        .frame(width: 176, height: 232)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var infoPlaceholderText: some View {
        VStack(alignment: .leading) {
            ForEach(0..<3) {_ in
                SkeletonCapsuleItem()
            }
            Spacer()
        }
        .padding(10)
    }
}


#Preview {
    SkeletonItem()
}
