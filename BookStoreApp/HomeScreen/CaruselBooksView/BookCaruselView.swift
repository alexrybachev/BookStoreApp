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
                
                if book.coverI == nil {
                    Image(.bookDef)
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                } else {
                    KFImage(URL(string: Kf.path(value: book.coverI ?? 0, path: .id)))
                        .placeholder({
                            SkeletonRectItem()
                                .frame(width: 90, height: 120)
                        })
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                }
                
                ZStack(alignment: .leading) {
                    Color.black
                    
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        //                            .minimumScaleFactor(0.01)
                            .lineLimit(2)
                        Spacer()
                        
                        Text(book.authorNames)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 6)
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
