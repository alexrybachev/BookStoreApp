//
//  GridBooksView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct GridBooksView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(0..<8) {_ in 
                        BookCaruselView()
                    }
                }
                .padding(.horizontal, 5)
            }
            .background(.backgroundApp)
        }
    }
}

#Preview {
    GridBooksView()
}
