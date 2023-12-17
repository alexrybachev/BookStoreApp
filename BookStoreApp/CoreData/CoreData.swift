//
//  CoreData.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/14/23.
//

import CoreData

final class CoreData: ObservableObject {
    
    @Published var savedRecentBooks: [BooksEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Container")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data - \(error.localizedDescription)")
            } else {
                print("Successfully loaded Core Data")
            }
        }
        fetchRecentBooks()
//        deleteAllData()
//        savedRecentBooks.removeAll()
    }
    
    func fetchRecentBooks() {
        let request = NSFetchRequest<BooksEntity>(entityName: "BooksEntity")
        do {
            savedRecentBooks = try container.viewContext.fetch(request)
        } catch let error {
            print("Data fetch request error - \(error)")
        }
    }
    
    func addBooksFromDetailBooks(detailBooks: [DetailBook]) {
        for detailBook in detailBooks {
            addBook(book: detailBook, iaBook: "", authorName: "")
        }
    }
    
    
    func addBook(book: DetailBook, iaBook: String, authorName: String) {
        let newBook = BooksEntity(context: container.viewContext)
        newBook.key = book.key
        //        newBook.name = book.subjectNames
        newBook.titleName = book.title
        newBook.author = authorName
        newBook.iaBooks = iaBook
        newBook.coverId = String(book.covers?.first ?? 0)
        saveData()
    }
    
    func saveData() {
        do {
            fetchRecentBooks()
            try container.viewContext.save()
        } catch let error {
            print("Error saving - \(error)")
        }
    }
    
    func deleteAllData() {
           let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "BooksEntity")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

           do {
               try container.viewContext.execute(deleteRequest)
               try container.viewContext.save()
               savedRecentBooks.removeAll()

           } catch let error {
               print("Error deleting all data - \(error)")
           }
       }

}
