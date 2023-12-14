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
    let ia: [String]?
    
    var authorNames: String {
        guard let authorName else { return "No authors"}
        return authorName.joined(separator: ", ")
    }
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
    
    var authorNames: String {
        authors.map { $0.name }.joined(separator: ", ")
    }

}

struct Authors: Decodable {
    let key: String
    let name: String
}

//MARK: - DetailBook
struct DetailBook: Decodable {
    let key: String?
    let title: String?
    let description: Any?
//    let links: [Link]?
    let covers: [Int]?
    let subjectPlaces: [String]?
    let subjects: [String]?
    let subjectPeople: [String]?
    let authors: [Author]?
//    let excerpts: [Excerpt]?
    let created: Created?
    
    var subjectNames: String {
        guard let subjects else { return "No subjects"}
        return subjects.joined(separator: ", ")
    }
    
    private enum CodingKeys: String, CodingKey {
            case description
//            case links
            case title
            case covers
            case subjectPlaces
            case subjects
            case subjectPeople
            case key
            case authors
//            case excerpts
            case created
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // Декодируем остальные свойства
//            links = try container.decode([Link].self, forKey: .links)
            title = try container.decodeIfPresent(String.self, forKey: .title)
//            covers = try container.decode([Int].self, forKey: .covers)
//            subjectPlaces = try container.decode([String].self, forKey: .subjectPlaces)
//            subjects = try container.decode([String].self, forKey: .subjects)
//            subjectPeople = try container.decode([String].self, forKey: .subjectPeople)
            key = try container.decodeIfPresent(String.self, forKey: .key)
            authors = try container.decode([Author].self, forKey: .authors)
//            excerpts = try container.decode([Excerpt].self, forKey: .excerpts)
            created = try container.decode(Created.self, forKey: .created)

            // Декодируем subjectPlaces
            if let subjectPlacesData = try? container.decode(Data.self, forKey: .subjectPlaces),
               let subjectPlacesJSON = try? JSONSerialization.jsonObject(with: subjectPlacesData), // options?
               let subjectPlacesArray = subjectPlacesJSON as? [String] {
                subjectPlaces = subjectPlacesArray
            } else {
                subjectPlaces = []
            }
            
            // Декодируем covers
            if let covers = try? container.decode([Int].self, forKey: .covers) {
                self.covers = covers
            } else {
                covers = nil
            }
            
            // Декодируем subjects
            if let subjectsData = try? container.decode([String].self, forKey: .subjects) {
                subjects = subjectsData
            } else {
                subjects = nil
            }
            
            // Декодируем subjectPeople
            if let subjectPeopleData = try? container.decode(Data.self, forKey: .subjectPeople),
               let subjectPeopleJSON = try? JSONSerialization.jsonObject(with: subjectPeopleData), // options?
               let subjectPeopleArray = subjectPeopleJSON as? [String] {
                subjectPeople = subjectPeopleArray
            } else {
                subjectPeople = []
            }
            
            // Декодируем description с использованием JSONSerialization
            if let descriptionString = try? container.decode(String.self, forKey: .description) {
                description = descriptionString
            } else if let descriptionArray = try? container.decode([String: String].self, forKey: .description) {
                description = descriptionArray
            } else {
                description = nil
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
    
    var readUrl: String {
        guard let ia else { return "" }
        guard let url = ia.first else { return "" }
        return "https://archive.org/embed/\(url)"
        
    }
}

struct Availability: Decodable {
    let isbn: String?
}

// MARK: - Rating

struct Rating: Decodable {
    let summary: FieldsRating?
    
    var rating: String {
        guard let rating = summary?.average else { return " 0/5"}
        let result = String(format: "%.2f", rating)
        return "\(result)/5"
    }
}

struct FieldsRating: Decodable {
    let average: Double?
    let sortable: Double?
}
