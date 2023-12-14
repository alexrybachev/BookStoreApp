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
    @Environment(\.managedObjectContext) var data
    let id: String
    var network = NetworkDataFetcher()
    @ObservedObject var coreData = CoreData()
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
