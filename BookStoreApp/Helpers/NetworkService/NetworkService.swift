//
//  NetworkService.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

enum Endpoint {
    case getSearchQuery(String)
    case getCategories(String)
}

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func searcQueryComponents(search: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openlibrary.org"
        urlComponents.path = "/search.json"
//        urlComponents.query = search
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: search)
        ]
        return urlComponents
    }
    
    func getCategoriesComponents(category name: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openlibrary.org"
        urlComponents.path = "/subjects/\(name.lowercased()).json"
        return urlComponents
    }
    
    func getPosts(query: Endpoint) async throws -> Data {
        var urlComponents = URLComponents()
        switch query {
        case let .getSearchQuery(searchQuery):
            urlComponents = searcQueryComponents(search: searchQuery)
        case let .getCategories(name):
            urlComponents = getCategoriesComponents(category: name)
        }
        
        guard let url = urlComponents.url else {
            throw NetworkingError.badUrl
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = RequestMethod.get.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: request)
            print("REQUEST: - \(request)")
            
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.badResponse }
            print("Response status code: \(httpResponse.statusCode)")
            //                print("Response posts data = \(String(decoding: data, as: UTF8.self))")
            return data
        } catch {
            print(error.localizedDescription)
            throw NetworkingError.badRequest
        }
    }
}

