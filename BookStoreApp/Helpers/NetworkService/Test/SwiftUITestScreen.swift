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
    @State var model: [Library] = []
    @State var textinput: String = "World"
    
    var body: some View {
        VStack {
            TextField("Search", text: $textinput)
            List {
                ForEach(model, id: \.id) { library in
                    ForEach(library.docs, id: \.title) { libraryDocs in
                    //                KFImage(URL(string: "image.docs[0]."))
                    //                    .imageScale(.large)
                    //                    .scaledToFit()
                    //                    .frame(width: 100, height: 100)
                        Text(libraryDocs.title )
                }
            }
            }
            .task {
                do {
                    let data = try await network.searchQuery(search: "harry")
                    model.append(data)
                    print("Model \(model)")
                } catch {
                    print("Error: \(error)")
                }
            }
            
           
        }
        .padding()
    }
}

#Preview {
    SwiftUITestScreen(image: "", textinput: "")
}

