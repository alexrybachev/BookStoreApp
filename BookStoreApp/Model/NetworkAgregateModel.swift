//
//  NetworkAgregateModel.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/5/23.
//

import Foundation


class NetworkAggregateModel: ObservableObject {
    
    @Published var searchBooksList: [Docs] = []
//    @Published var coverIdList: [String] = []
    @Published var categoriesList: [Works] = []
    @Published var isbnDictionary = [String: String]()

    func updateIsbn(for key: String, with newIsbn: String) {
            if let index = searchBooksList.firstIndex(where: { $0.key == key }) {
                searchBooksList[index].isbn = [newIsbn]
            }
        }
}
