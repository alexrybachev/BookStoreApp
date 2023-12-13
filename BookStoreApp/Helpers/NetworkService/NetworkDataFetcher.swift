//
//  NetworkDataFetcher.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

final class NetworkDataFetcher {
    
    //MARK: - request Search
    func searchQuery(search: String) async throws -> SearchBooks {
        let data = try await NetworkService.shared.getPosts(query: .getSearchQuery(search))
        let decodedData = try decodeJSON(type: SearchBooks.self, from: data)
        return decodedData
    }
    
    //MARK: - request Categories
    func getCategories(name: String) async throws -> Categories {
        let data = try await NetworkService.shared.getPosts(query: .getCategories(name))
        let decodedData = try decodeJSON(type: Categories.self, from: data)
        return decodedData
    }
    
    //MARK: - request TopTrends
    func getTopTrends(trend: SortTrends) async throws -> TopTrends {
        let data = try await NetworkService.shared.getPosts(query: .getTopTrends(trend.switchTrends))
        let decodedData = try decodeJSON(type: TopTrends.self, from: data)
        return decodedData
    }
    
    //MARK: - request DetailBook by Identifier
    func getDetailBook(id: String) async throws -> DetailBook {
        print(id)
        let data = try await NetworkService.shared.getPosts(query: .getDetailBook(id))
        let decodedData = try decodeJSON(type: DetailBook.self, from: data)
        return decodedData
    }
    
    //MARK: - request by Identifier
    func getSearchById(id: String) {
        
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
