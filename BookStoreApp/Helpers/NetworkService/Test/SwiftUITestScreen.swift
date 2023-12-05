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
    
    var body: some View {
        VStack {
            TextField("Search", text: $textinput)
            List {
                ForEach(networkAggregateModel.searchBooksList, id: \.id) { library in
                    ForEach(library.docs, id: \.isbn) { libraryDocs in
                        Text(libraryDocs.title )
                        let isbn = libraryDocs.isbn?.first ?? ""
//                        ForEach(libraryDocs.isbn ?? [""], id: \.self) { isbn in
                            KFImage(URL(string: "https://covers.openlibrary.org/b/isbn/\(isbn)-L.jpg"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                            
                        }
                }
                
//                ForEach(networkAggregateModel.coverIdList, id: \.self) { idBook in
//                    KFImage(URL(string: "https://covers.openlibrary.org/b/isbn/\(idBook)-L.jpg"))
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                    
//                }
                }
            }
        
        .task {
            do {
                let data = try await network.searchQuery(search: "harry potter")
                networkAggregateModel.searchBooksList.append(data)
//                                    print("Model \(networkAggregateModel.searchBooksList)")
                do {
                    let data = try await network.fetchCoverImages(isbnArray:  networkAggregateModel.searchBooksList)
                    networkAggregateModel.coverIdList.append(contentsOf: data)
                } catch {
                    print("Error fetching cover images: \(error.localizedDescription)")
                }
            } catch {
                print("Error: \(error)")
            }
        }
//        .task {
//            do {
//                let data = try await network.fetchCoverImages(isbnArray:  networkAggregateModel.searchBooksList)
//                networkAggregateModel.coverIdList.append(contentsOf: data)
//                print("Model \( networkAggregateModel.coverIdList)")
//            } catch {
//                print("Error fetching cover images: \(error.localizedDescription)")
//            }
//        }
        .padding()
    }
}



#Preview {
    SwiftUITestScreen(image: "", networkAggregateModel: NetworkAggregateModel(), textinput: "")
}

