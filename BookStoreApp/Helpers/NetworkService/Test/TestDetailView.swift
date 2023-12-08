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
                ForEach(networkAggregateModel.detailBooks, id:\.key) { doc in
                        HStack {
                            
        
                            Text(doc.title ?? "")
                                .frame(height: 40)
                        }
                    }
                }
            }
            .task {
                do {
                    let data = try await network.getDetailBook(id: id)
                    networkAggregateModel.detailBooks.append(data)
                } catch {
                    //
                }
            }
        }
    }


#Preview {
    TestDetailView(id: "OL82586W", networkAggregateModel: NetworkAggregateModel())
}
