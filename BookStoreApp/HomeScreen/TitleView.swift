//
//  TitleView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct TitleView: View {
    
    @State var text: String
    @Binding var seeMore: Bool
    
    var body: some View {
        HStack {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                seeMore.toggle()
            } label: {
                Text(seeMore ? "see more" : "see less")
                    .tint(.secondary)
            }
        }
    }
}

#Preview {
    TitleView(text: "Top Books", seeMore: .constant(true))
}
