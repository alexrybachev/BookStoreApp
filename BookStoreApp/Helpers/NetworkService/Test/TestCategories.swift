//
//  TestCategories.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/6/23.
//

import SwiftUI

struct TestCategories: View {
    var network = NetworkDataFetcher()
    @StateObject var networkAggregateModel: NetworkAggregateModel
    var body: some View {
        List {
            ForEach(networkAggregateModel.categoriesList, id: \.key) { books in
                ForEach(books.works, id: \.key) { book in
                    Text(book.title)
                }
            }
        }
        .task {
            do {
                let data = try await network.getCategories(name: "love")
                networkAggregateModel.categoriesList.append(data)
            } catch {
                print("No response categories")
            }
        }
    }
}

#Preview {
    TestCategories(network: NetworkDataFetcher(), networkAggregateModel: NetworkAggregateModel())
}
