//
//  CategoryDetailsView.swift
//  BookStoreApp
//
//  Created by Alex on 08.12.2023.
//

import SwiftUI
import Kingfisher

struct Book: Hashable {
    var image: String
    var description: String
}

struct CategoryDetailsView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    
    let category: String
    
    var body: some View {
        List {
            ForEach(viewModel.categoriesList, id: \.key) { book in
                HStack(spacing: 20) {
                    KFImage(URL(string: Kf.path(value: book.coverId ?? 0, path: .id)))
                        .placeholder({
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(2.0, anchor: .center)
                        })
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .cornerRadius(10)
                    
                    Text(book.title)
                        .padding(.vertical, 8)
                        .lineLimit(5)
                        .truncationMode(.tail)
                }
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Category")
        .preferredColorScheme(viewModel.isLightTheme ? .light : .dark)
        .task {
            viewModel.fetchCategoriesBooks(category: category)
        }
        .onDisappear {
            viewModel.categoriesList = []
        }
    }
    
}

//#Preview {
//    let sampleBooks = [
//        Book(image: "book_cover", description: "Описание книги"),
//        Book(image: "book_cover", description: "Описание книги"),
//        Book(image: "book_cover", description: "La la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala la")
//    ]
//
//    let viewModel = BookAppViewModel()
//    return CategoryDetailsView(books: sampleBooks)
//        .environmentObject(viewModel)
//}
