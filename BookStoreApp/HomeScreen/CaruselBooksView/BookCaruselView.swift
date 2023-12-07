//
//  BookCaruselView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 06.12.2023.
//

import SwiftUI

struct BookCaruselView: View {
    var body: some View {
        VStack {
            Image(.bookCover)
                .resizable()
                .frame(width: 91, height: 141)
                .padding(.top, 10)
                .offset(y: 20)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Classical")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text("The Picture of Dorian Gray")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("Oscar Wilde")
                        .font(.caption)
                }
                .padding(.vertical, 10)
                .frame(width: 176)
            }
            .background(.backgroundTextBooks)
            .foregroundStyle(.white)
        }
        //.frame(width: 176, height: 232)
        .background(.backgroundBooks)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    BookCaruselView()
}
