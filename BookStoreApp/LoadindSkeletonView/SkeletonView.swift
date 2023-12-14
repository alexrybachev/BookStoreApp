//
//  SkeletonView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.12.2023.
//

import SwiftUI

struct SkeletonView: View {
    private let rows = [GridItem()]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20)  {
                ForEach(0..<2) {_ in
                    SkeletonItem()
                }
            }
        }
    }
}

#Preview {
    SkeletonView()
}
