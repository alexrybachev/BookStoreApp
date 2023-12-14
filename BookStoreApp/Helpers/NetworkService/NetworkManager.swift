//
//  NetworkManager.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 10.12.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Метод по созданию параметров
    private func makeParameters(for endPoint: Endpoint, with query: String?) -> [String: String] {
        var parameters: [String: String] = [:]
        
        switch endPoint {
        case .getSearchQuery(_):
            if let query = query {
                parameters["q"] = "\(query)"
                parameters["fields"] = "*,availability"
                parameters["limit"] = "20"
            }
        case .getTopTrends(_):
            parameters["fields"] = "*,availability"
            parameters["limit"] = "10"
        default:
            break
        }
        
        return parameters
    }
    
    /// Метод создает URL
    private func createURL(for endPoint: Endpoint, with query: String?) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path
        
        components.queryItems = makeParameters(for: endPoint, with: query).compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return components.url
    }
    
    private func getPosts(endpoint: Endpoint, with query: String?) async throws -> Data {
        
        guard let url = createURL(for: endpoint, with: query) else {
            throw NetworkingError.badUrl
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = RequestMethod.get.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: request)
            print("REQUEST: - \(request)")
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.badResponse }
            print("Response status code: \(httpResponse.statusCode)")
            
            return data
        } catch {
            print(error.localizedDescription)
            throw NetworkingError.badRequest
        }
    }
}

// MARK: - Decodable

private extension NetworkManager {
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T {
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

// MARK: - Public methods

extension NetworkManager {
    
    /// Request TopTrends
    func getTopTrends(trend: SortTrends) async throws -> TopTrends {
        let data = try await getPosts(endpoint: .getTopTrends(trend.switchTrends), with: nil)
        let decodedData = try decodeJSON(type: TopTrends.self, from: data)
        return decodedData
    }
    
    
    /// Request Search
    func searchQuery(search: String) async throws -> SearchBooks {
        let data = try await getPosts(endpoint: .getSearchQuery(search), with: search)
        let decodedData = try decodeJSON(type: SearchBooks.self, from: data)
        return decodedData
    }
    
    /// Request Categories
    func getCategories(name: String) async throws -> Categories {
        let data = try await getPosts(endpoint: .getCategories(name), with: name)
        let decodedData = try decodeJSON(type: Categories.self, from: data)
        return decodedData
    }
    
    /// Request DetailBook by Identifier
    func getDetailBook(id: String) async throws -> DetailBook {
        let data = try await getPosts(endpoint: .getDetailBook(id), with: id)
        let decodedData = try decodeJSON(type: DetailBook.self, from: data)
        return decodedData
    }
    
    /// Request by Identifier
    func getSearchById(id: String) {
        
    }
    
    /// Request Rating
    func getRatingById(id: String) async throws -> Rating {
        let data = try await getPosts(endpoint: .getRating(id), with: id)
        let decodedData = try decodeJSON(type: Rating.self, from: data)
        return decodedData
    }
    
}


