//
//  TestDetailView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/7/23.
//

import SwiftUI
import Kingfisher

struct TestDetailView: View {
    let id: String
    var network = NetworkDataFetcher()
    @StateObject var networkAggregateModel: NetworkAggregateModel
    var body: some View {
        VStack {
            List {
                ForEach(networkAggregateModel.searchBooksList, id: \.key) { doc in
                    HStack {
                        let isbn = doc.isbn?.first ?? ""
                        
                        KFImage(URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-L.jpg"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 160)
                        Text(doc.title)
                    }
                }
            }
            .task {
                do {
                    let data = try await network.getDetailBook(id: "9798532071964")
                    networkAggregateModel.detailBooks.append(data)
                } catch {
                    //
                }
            }
        }
    }
}

#Preview {
    TestDetailView(id: "someID", networkAggregateModel: NetworkAggregateModel())
}
