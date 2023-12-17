//
//  TestDetailView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/7/23.
//

import SwiftUI
import Kingfisher
//import CoreData

struct TestDetailView: View {
    
    @EnvironmentObject var coreData: CoreData
    @StateObject var networkAggregateModel: NetworkAggregateModel
    
    let id: String
    var network = NetworkDataFetcher()
    
    var body: some View {
        VStack {
            List {
//                ForEach(networkAggregateModel.detailBooks, id:\.key) { doc in
//                        Text(doc.title ?? "")
//                            .frame(height: 40)
//                }
                ForEach(coreData.savedRecentBooks, id: \.self) { books in
                    HStack {
                        Text(books.author ?? "")
                            .frame(height: 40)
                    }
                }
            }
        }
//        .task {
//            do {
//                let data = try await network.getDetailBook(id: id)
//                networkAggregateModel.detailBooks.append(data)
////                coreData.addBooksFromDetailBooks(detailBooks: networkAggregateModel.detailBook)
//            } catch {
//                //
//            }
//        }
        .onAppear() {
            coreData.fetchRecentBooks()
        }
        .onDisappear() {
//            coreData.addBooksFromDetailBooks(detailBooks: networkAggregateModel.detailBooks)
            print("SavedRecentBooks - \(coreData.savedRecentBooks)")
        }
    }
}


#Preview {
    TestDetailView(networkAggregateModel: NetworkAggregateModel(), id: "id")
}
