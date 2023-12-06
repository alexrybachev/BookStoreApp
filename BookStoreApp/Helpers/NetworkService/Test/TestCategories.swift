//
//  TestCategories.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/6/23.
//

import SwiftUI
import Kingfisher

struct TestCategories: View {
    var network = NetworkDataFetcher()
    @StateObject var networkAggregateModel: NetworkAggregateModel
    var body: some View {
        List {
            ForEach(networkAggregateModel.categoriesList, id: \.key) { books in
                HStack {
                    KFImage(URL(string: "https://covers.openlibrary.org/b/id/\(books.coverId)-L.jpg"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 160)
                    Text(books.title)
                        .font(.system(size: 20))
                        
                }
            }
        }
        .task {
            do {
                let data = try await network.getCategories(name: "love")
                networkAggregateModel.categoriesList.append(contentsOf: data.works)
            } catch {
                print("No response categories")
            }
        }
    }
}

#Preview {
    TestCategories(network: NetworkDataFetcher(), networkAggregateModel: NetworkAggregateModel())
}
