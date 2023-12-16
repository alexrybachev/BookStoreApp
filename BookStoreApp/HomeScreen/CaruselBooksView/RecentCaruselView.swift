//
//  RecentCaruselView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//

import SwiftUI
import Kingfisher

struct RecentCaruselView: View {
    
    @ObservedObject var coreData = CoreData()
    var title: String?
    var author: String?
    var image: String?
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.5)
            
            VStack(spacing: 0) {
//                if coreData.savedRecentBooks == nil {
//                    Image(.bookDef)
//                        .resizable()
//                        .scaledToFit()
//                        .padding(10)
//                } else {
//                KFImage(URL(string: Kf.path(value: image ?? "", path: .id)))
//                        .placeholder({
//                            ProgressView()
//                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
//                                .scaleEffect(2.0, anchor: .center)
//                        })
//                        .resizable()
//                        .scaledToFit()
//                        .padding(10)
//                }
                
                ZStack(alignment: .leading) {
                    Color.black
                    
                    VStack(alignment: .leading) {
                        
                        Text(title ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.01)
                            
                        Text(author ?? "")
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding(10)
                    .foregroundStyle(.white)
                }
                .frame(height: 92)
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

#Preview {
    RecentCaruselView(title: "Some title", author: "Some author")
}
