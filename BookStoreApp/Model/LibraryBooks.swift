//
//  Model.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

struct LibraryBooks: Decodable, Identifiable {
    var id: Int?
    let numFound: Int
    let start: Int
    let numFoundExact: Bool
    let docs: [Docs]
}

// MARK: - Books
struct Docs: Decodable {
    let key: String
    let title: String
    let authorName: [String]?
    let isbn: [String]?

}

// MARK: - Editions
struct Editions: Decodable {
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [EditionsDoc]
}

// MARK: - EditionsDoc
struct EditionsDoc: Decodable {
    let key, title: String
}

// MARK: - Categories
struct Categories: Decodable {
    let key: String
    let name: String
    let subjectType: String
    let workCount: Int
    let works: [Works]
}

struct Works: Decodable {
    let key: String
    let title: String
    let coverId: Int
    let subject: [String]
    let authors: [Authors]
    let firstPublishYear: Int
}

struct Authors: Decodable {
    let key: String
    let name: String
}

struct DetailBook: Decodable {
    let title: String?
    let key: String
    let description: [Description]?
}

struct Description: Decodable {
    let type: String
    let value: String
}

//MARK: - Top Trending
struct TopTrends: Decodable {
    let query: String
    let works: [WorksTrends]
}

struct WorksTrends: Decodable {
    let key: String
    let title: String
    let authorName: [String]?
    let ia: [String]?
}

////MARK: - Search By ISBN
//struct SearchID: Codable {
//    let identifiers: Identifiers
//    let title: String
//    let authors: [TypeElement]
//    let publishDate: String
//    let publishers: [String]
//    let covers: [Int]
//    let contributions: [String]
//    let languages: [TypeElement]
//    let sourceRecords, localID: [String]
//    let type: TypeElement
//    let firstSentence: Created
//    let key: String
//    let numberOfPages: Int
//    let works: [TypeElement]
//    let classifications: Classifications
//    let ocaid: String
//    let isbn10, isbn13: [String]
//    let latestRevision, revision: Int
//    let created, lastModified: Created
//
//}
//
//// MARK: - TypeElement
//struct TypeElement: Codable {
//    let key: String
//}
//
//// MARK: - Classifications
//struct Classifications: Codable {
//}
//
//// MARK: - Created
//struct Created: Codable {
//    let type, value: String
//}
//
//// MARK: - Identifiers
//struct Identifiers: Codable {
//    let goodreads, librarything: [String]
//}

