//
//  ItemViewSearch.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.12.2023.
//
import SwiftUI
import Kingfisher

struct ItemViewSearch: View {
    
    let book: Docs
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.5)
            
            VStack(spacing: 0) {
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
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    ItemViewSearch(book: Docs(key: "", title: "33", authorName: nil, isbn: nil, publishYear: [2003], ia: ["ia"]))
                   
}
