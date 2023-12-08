//
//  SwiftUITestScreen.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import SwiftUI
import Kingfisher

struct SwiftUITestScreen: View {
    var image: String
    var network = NetworkDataFetcher()
    @StateObject var networkAggregateModel: NetworkAggregateModel
    @State var textinput: String = "World"
    @State var isbnArray = [Docs]()
    @State var isbn = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $textinput)
                List {
                    ForEach(networkAggregateModel.searchBooksList, id: \.key) { doc in
                        NavigationLink(destination: TestDetailView(id: doc.key, networkAggregateModel: NetworkAggregateModel())) {
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
                }
            }
            .task {
                do {
                    let data = try await network.searchQuery(search: "harry potter")
                    networkAggregateModel.searchBooksList.append(contentsOf: data.docs)
//                    print(networkAggregateModel.searchBooksList)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        .padding()
    }
}



#Preview {
    SwiftUITestScreen(image: "", networkAggregateModel: NetworkAggregateModel(), textinput: "")
}

