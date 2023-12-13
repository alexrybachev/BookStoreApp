//
//  BookCaruselView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 06.12.2023.
//

import SwiftUI
import Kingfisher

struct BookCaruselView: View {
    
    let book: WorksTrends
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.5)
            
            VStack(spacing: 0) {
                
                KFImage(URL(string: Kf.path(value: book.coverI ?? 0, path: .id)))
                    .placeholder({
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(2.0, anchor: .center)
                    })
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                
                ZStack(alignment: .leading) {
                    Color.black
                    
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.01)
                            
                        Text(book.authorNames)
                            .font(.caption)
                        
                        Spacer()
                    }
                    .padding(10)
                    .foregroundStyle(.white)
                }
                .frame(height: 92)
            }
        }
        .frame(width: 176, height: 232)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    BookCaruselView(
        book: WorksTrends(key: "key",
                          title: "title",
                          authorName: ["authorName", "authorName"],
                          ia: ["ia", "ia"],
                          authorKey: ["authorKey", "authorKey"],
                          coverI: 10,
                          availability: Availability(isbn: "ISBN"))
    )
}
