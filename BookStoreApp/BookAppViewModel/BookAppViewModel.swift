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
    
    
    
    #warning("доделать searchBooksList, categoriesList, detailBooks")
    @Published var searchBooksList: [Docs] = []
    @Published var categoriesList: [CategoriesBooks] = []
    @Published var detailBooks: [DetailBook] = []

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
                    print("WORKS:\n\(trendsQuery.works)")
                    self.topTrends = trendsQuery.works
                }
            } catch let error {
                print("Fetch Trends Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSearchBooks() {
        
    }

}
