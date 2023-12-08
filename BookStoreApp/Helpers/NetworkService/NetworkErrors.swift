//
//  NetworkErrors.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

enum NetworkingError: Error {
    case badUrl
    case badRequest
    case badResponse
    case invalidData
}
