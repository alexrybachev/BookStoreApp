//
//  Model.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/3/23.
//

import Foundation

// MARK: - SearchBooks
struct SearchBooks: Decodable, Identifiable {
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
    let publishYear: [Int]
}

// MARK: - Categories
struct Categories: Decodable {
    let key: String
    let name: String
    let subjectType: String
    let workCount: Int
    let works: [CategoriesBooks]
}

struct CategoriesBooks: Decodable {
    let key: String
    let title: String
    let coverId: Int?
    let subject: [String]
    let iaCollection: [String]
    let authors: [Authors]
    let firstPublishYear: Int
    let ia: String?
}

struct Authors: Decodable {
    let key: String
    let name: String
}

//MARK: - DetailBook
struct DetailBook: Decodable {
    let key: String?
    let title: String?
    let description: [String: AnyObject]?
    let links: [Link]?
    let covers: [Int]?
    let subjectPlaces: [String]?
    let subjects: [String]?
    let subjectPeople: [String]?
    let authors: [Author]?
    let excerpts: [Excerpt]?
    let created: Created?
    
    private enum CodingKeys: String, CodingKey {
            case description
            case links
            case title
            case covers
            case subjectPlaces
            case subjects
            case subjectPeople
            case key
            case authors
            case excerpts
            case created
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // Декодируем остальные свойства
            links = try container.decode([Link].self, forKey: .links)
            title = try container.decodeIfPresent(String.self, forKey: .title)
            covers = try container.decode([Int].self, forKey: .covers)
            subjectPlaces = try container.decode([String].self, forKey: .subjectPlaces)
            subjects = try container.decode([String].self, forKey: .subjects)
            subjectPeople = try container.decode([String].self, forKey: .subjectPeople)
            key = try container.decodeIfPresent(String.self, forKey: .key)
            authors = try container.decode([Author].self, forKey: .authors)
            excerpts = try container.decode([Excerpt].self, forKey: .excerpts)
            created = try container.decode(Created.self, forKey: .created)

            // Декодируем description с использованием JSONSerialization
            if let descriptionData = try? container.decode(Data.self, forKey: .description),
               let descriptionJSON = try? JSONSerialization.jsonObject(with: descriptionData, options: []),
               let descriptionDict = descriptionJSON as? [String: AnyObject] {
                description = descriptionDict
            } else {
                description = [:]
            }
        }
}


struct Author: Decodable {
    let author: TypeClass
    let type: TypeClass
}

struct TypeClass: Decodable {
    let key: String
}

struct Created: Decodable {
    let type: String
    let value: String
}

struct Excerpt: Decodable {
    let comment: String
    let author: TypeClass
    let excerpt: String
}

struct Link: Decodable {
    let url: String
    let title: String
    let type: TypeClass
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
    let authorKey: [String]?
    let coverI: Int?
    let availability: Availability?
    
    var authorNames: String {
        guard let authorName else { return "" }
        let sets = Set(authorName)
        return sets.joined(separator: ", ")
    }
    
    var urlBook: String {
        guard let availability else { return "" }
        guard let isbn = availability.isbn else { return "" }
        return "https://covers.openlibrary.org/b/isbn/\(isbn)-M.jpg"
    }
}

struct Availability: Decodable {
    let isbn: String?
}
