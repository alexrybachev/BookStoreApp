//
//  KingFisher Extension.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/11/23.
//

import Foundation

final class Kf {
    enum Endpoint {
        case isbn
        case id
        case oclc
        case lccn
        case olid
    }
    
    static func path<T: CustomStringConvertible>(value: T, path: Endpoint) -> String {
        switch path {
        case .isbn:
            "https://covers.openlibrary.org/b/isbn/\(value)-L.jpg"
        case .id:
            "https://covers.openlibrary.org/b/id/\(value)-L.jpg"
        case .oclc:
            "https://covers.openlibrary.org/b/oclc/\(value)-L.jpg"
        case .lccn:
            "https://covers.openlibrary.org/b/lccn/\(value)-L.jpg"
        case .olid:
            "https://covers.openlibrary.org/b/olid/\(value)-L.jpg"
        }
    }
}
