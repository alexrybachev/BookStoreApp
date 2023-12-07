//
//  CaruselBooksView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 06.12.2023.
//

import SwiftUI

struct CaruselBooksView: View {
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(0..<5) {_ in 
                    BookCaruselView()
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    CaruselBooksView()
}
