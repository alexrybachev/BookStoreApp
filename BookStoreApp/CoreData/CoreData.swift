//
//  CoreData.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/14/23.
//

import Foundation
import CoreData

class CoreData: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedRecentBooks: [RecentBooks] = []
    
    init() {
        container = NSPersistentContainer(name: "RecentBooks")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data - \(error)")
            } else {
                print("Successfully loaded Core Data")
            }
        }
        fetchRecentBooks()
    }
    
    func fetchRecentBooks() {
        let request = NSFetchRequest<RecentBooks>(entityName: "author")
        do {
           savedRecentBooks = try container.viewContext.fetch(request)
        } catch let error {
            print("Data fetch request error - \(error)")
        }
    }
    
    func addBook(name: String) {
        let newBook = RecentBooks(context: container.viewContext)
        newBook.author = name
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchRecentBooks()
        } catch let error {
            print("Error saving - \(error)")
        }
    }
}
