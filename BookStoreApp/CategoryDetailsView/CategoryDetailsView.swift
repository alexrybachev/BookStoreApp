//
//  CategoryDetailsView.swift
//  BookStoreApp
//
//  Created by Alex on 08.12.2023.
//

import SwiftUI

struct Book: Hashable {
    var image: String
    var description: String
}

struct CategoryDetailsView: View {
    @EnvironmentObject private var viewModel: BookAppViewModel
    var books: [Book]
    let categoryText = "Category"

    var body: some View {
        List {
            ForEach(books, id: \.self) { book in
                Section {
                    HStack(spacing: 20) {
                        Image(book.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 120)
                            .cornerRadius(10)

                        Text(book.description)
                            .padding(.vertical, 8)
                            .lineLimit(5)
                            .truncationMode(.tail)
                    }
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(categoryText)
        .preferredColorScheme(viewModel.isLightTheme ? .light : .dark)
    }
}

#Preview {
    let sampleBooks = [
        Book(image: "book_cover", description: "Описание книги"),
        Book(image: "book_cover", description: "Описание книги"),
        Book(image: "book_cover", description: "La la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala laLa la lalal alala alalla lala la")
    ]

    let viewModel = BookAppViewModel()
    return CategoryDetailsView(books: sampleBooks)
        .environmentObject(viewModel)
}
