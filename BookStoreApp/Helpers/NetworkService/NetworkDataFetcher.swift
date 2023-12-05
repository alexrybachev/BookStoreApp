//
//  NetworkDataFetcher.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

final class NetworkDataFetcher {
    
    func searchQuery(search: String) async throws -> Library {
        let data = try await NetworkService.shared.getPosts(query: .getSearchQuery(search))
        let decodedData = try decodeJSON(type: Library.self, from: data)
        return decodedData
    }
    
    
//    func fetchISBN(isbnArray: [Library]) async throws -> [String] {
//        
//    }
//    
    func fetchCoverImages(isbnArray: [Docs]) async throws -> [String] {
        var array = [String]()
        for libraryItem in isbnArray {
            if let isbn = libraryItem.isbn {
                array.append(isbn.first ?? "")
            }
        }
        
        for isbnElement in array {
            _ = try await NetworkService.shared.getPosts(query: .getCoverImage(isbnElement))
        }
        return array
    }
}

extension NetworkDataFetcher {
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            throw NetworkingError.invalidData
        }
    }
}
