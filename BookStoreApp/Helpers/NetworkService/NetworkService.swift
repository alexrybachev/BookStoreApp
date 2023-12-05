//
//  NetworkService.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

enum Endpoint {
    case getSearchQuery(String)
    case getCoverImage(String)
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
    
    func getCoverComponents(id isbn: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "covers.openlibrary.org"
        urlComponents.path = "/b/isbn/\(isbn)-L.jpg"
//        urlComponents.query = ID
//        urlComponents.queryItems = [
////            URLQueryItem(name: "key", value: "isbn"),
//            URLQueryItem(name: "value", value: isbn),
//            URLQueryItem(name: "size", value: "-M")
//        ]
        return urlComponents
    }
    
    func getPosts(query: Endpoint) async throws -> Data {
        var urlComponents = URLComponents()
        switch query {
        case let .getSearchQuery(searchQuery):
            urlComponents = searcQueryComponents(search: searchQuery)
        case let .getCoverImage(id):
            urlComponents = getCoverComponents(id: id)
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

