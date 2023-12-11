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
                    KFImage(URL(string: Kf.path(value: books.coverId, path: .id)))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 160)
                    VStack(alignment: .leading) {
                        Text(books.title)
                            .font(.system(size: 20))
                        Text(String(books.firstPublishYear))
                            .font(.system(size: 20))
                    }
                }
            }
            ForEach(networkAggregateModel.topTrends, id: \.query) { topBooks in
                ForEach(topBooks.works, id: \.key) { books in
                    Text(books.title)
                }
            }
        }
        .task {
            do {
                let data = try await network.getCategories(name: "Classic")
                networkAggregateModel.categoriesList.append(contentsOf: data.works)
                let topData = try await network.getTopTrends(trend: .thisWeek)
                networkAggregateModel.topTrends.append(topData)
//
            } catch {
                print("No response categories")
            }
        }
    }
}

#Preview {
    TestCategories(network: NetworkDataFetcher(), networkAggregateModel: NetworkAggregateModel())
}
