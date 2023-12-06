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
                ForEach(networkAggregateModel.searchBooksList, id: \.key) { doc in
                    HStack {
                        var isbn = doc.isbn?.last ?? ""
                        var urlString = "https://covers.openlibrary.org/b/isbn/\(isbn)-L.jpg"

                        KFImage.url(URL(string: urlString))
                          .loadDiskFileSynchronously()
                          .cacheMemoryOnly()
                          .fade(duration: 0.25)
                          .onProgress { receivedSize, totalSize in
                              
                          }
                          .onSuccess { result in
                              DispatchQueue.global().async {
                                  if let image = result.image as? UIImage {
                                      print(urlString)
                                      if image.size.width < 2.0 {
                                          // Изображение не подходит

                                          DispatchQueue.main.async {
                                              isbn = "0747561079"
                                              networkAggregateModel.isbnDictionary[doc.key] = "0747561079"
                                              networkAggregateModel.updateIsbn(for: doc.key, with: "0747561079")
                                              print(isbn, "new")
                                          }
                                      }
                                  }
                              }
                          }
                          .onFailure { error in }
                          .resizable()
                          .scaledToFill()
                          .frame(width: 120, height: 160)
                        Text(doc.title)
                    }
                }
            }
        }
        
        .task {
            do {
                let data = try await network.searchQuery(search: "harry potter")
                networkAggregateModel.searchBooksList.append(contentsOf: data.docs)
            } catch {
                print("Error: \(error)")
            }
        }
        .padding()
    }
}



#Preview {
    SwiftUITestScreen(image: "", networkAggregateModel: NetworkAggregateModel(), textinput: "")
}

