//
//  RecentCaruselView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//

import SwiftUI
import Kingfisher

struct RecentBook: View {
    
    @ObservedObject var coreData: CoreData
    var title: String
    var author: String
    var image: String
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.5)
            
            VStack(spacing: 0) {
                
                KFImage(URL(string: Kf.path(value: image, path: .id)))
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
                        
                        Text(title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Spacer()
                        
                        Text(author)
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
    RecentBook(coreData: CoreData(), title: "Some title", author: "Some author", image: "6424160")
}
