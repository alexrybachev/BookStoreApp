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
