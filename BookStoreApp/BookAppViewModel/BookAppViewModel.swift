//
//  BookAppViewModel.swift
//  BookStoreApp
//
//  Created by Alex on 07.12.2023.
//

import SwiftUI

final class BookAppViewModel: ObservableObject {

    @AppStorage("appearanceSelection") var isLightThemeStorage: Bool = true
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @Published var selectedTrend: SortTrends = .now
    
    @Published var topTrends: [WorksTrends] = []
    @Published var categoriesList: [CategoriesBooks] = []
    @Published var searchBooksList: [Docs] = []
    @Published var detailBook: DetailBook?
    @Published var ratingBook: Rating?

    var isLightTheme: Bool {
        get { isLightThemeStorage }
        set { isLightThemeStorage = newValue }
    }
    
    /// Поиск трендовых книг
    func fetchTrendsBooks() {
        Task {
            do {
                let trendsQuery = try await NetworkManager.shared.getTopTrends(trend: selectedTrend)
                DispatchQueue.main.async {
//                    print("WORKS:\n\(trendsQuery.works)")
                    self.topTrends = trendsQuery.works
                }
            } catch let error {
                print("Fetch Trends Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Метод для поиска книг
    func fetchSearchBooks(query: String) {
        Task {
            do {
                let searchBooks = try await NetworkManager.shared.searchQuery(search: query)
                DispatchQueue.main.async {
//                    print("SEARCH WORKS:\n\(searchBooks.docs)")
                    self.searchBooksList = searchBooks.docs
                }
            } catch let error {
                print("Fetch Search Books Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Метод для получения категорий
    func fetchCategoriesBooks(category: String) {
        Task {
            do {
                let categories = try await NetworkManager.shared.getCategories(name: category)
                DispatchQueue.main.async {
//                    print("CATEGORY WORKS:\n\(categories.works)")
                    self.categoriesList = categories.works
                }
            } catch let error {
                print("Fetch Categories Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Метод для получения детальной информации о книге
    func fetchDetailBook(id: String) {
        Task {
            do {
                let detailBook = try await NetworkManager.shared.getDetailBook(id: id)
                DispatchQueue.main.async {
//                    print("DETAIL BOOK:\n\(detailBook)")
                    self.detailBook = detailBook
                }
            } catch let error {
                print("Fetch Detail Book Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Метод для получения рейтинга
    func fetchRatingBook(id: String) {
        Task {
            do {
                let ratingBook = try await NetworkManager.shared.getRatingById(id: id)
                DispatchQueue.main.async {
//                    print("RAITING BOOK:\n\(ratingBook)")
                    self.ratingBook = ratingBook
                }
            } catch let error {
                print("Fetch Rating Error: \(error.localizedDescription)")
            }
        }
    }

}
