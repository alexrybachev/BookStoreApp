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
