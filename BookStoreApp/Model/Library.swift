//
//  Model.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

struct Library: Decodable, Identifiable {
    var id: Int?
    let numFound: Int
    let start: Int
    let numFoundExact: Bool
    let docs: [Docs]
//    let libraryNumFound: Int
//    let q: String
//    let offset: JSONNull?

  
}

// MARK: - LibraryDoc
struct Docs: Decodable {
    let key: String
    let title: String
    let authorName: [String]?
    let isbn: [String]?
//    let editions: Editions

//    enum CodingKeys: String, CodingKey {
//        case key
//        case title
//        case authorName
////        case editions
//    }
}

// MARK: - Editions
struct Editions: Decodable {
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [EditionsDoc]
}

// MARK: - EditionsDoc
struct EditionsDoc: Codable {
    let key, title: String
}

// MARK: - Encode/decode helpers

//class JSONNull: Decodable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        // No-op
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
