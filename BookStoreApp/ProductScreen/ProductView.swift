//
//  ProductView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct ProductView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: BookAppViewModel
    @EnvironmentObject var coreData: CoreData
    @EnvironmentObject var user: User

    @State private var isWebViewPresented = false
    
    let keyBook: String
    let iaBook: String
    let authorName: String
    
    // static data
    static let backButtonIbage = "arrow.backward"
    static let likeButtonImage = "heart"
    static let likeButtonImageFill = "heart.fill"
    static let descriptionText = "Description:"

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            VStack {
                Text(viewModel.detailBook?.title ?? "Loading name...")
                    .font(.system(size: 24, weight: .semibold))
                
                PictureTextView(
                    coverId: String(viewModel.detailBook?.covers?.first ?? 0),
                    authorName: authorName,
                    category: viewModel.detailBook?.subjectNames ?? "No categories",
                    rating: viewModel.ratingBook?.rating ?? "No rating"
                ) {
                    openWebView()
                }
                .padding(.top, 16)
                .sheet(isPresented: $isWebViewPresented) {
                    WebView(urlString: iaBook)
                }
                
                Text(Self.descriptionText)
                
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ScrollView {
                    if let detailString = viewModel.detailBook?.description as? String {
                        Text(detailString)
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 14)
                    } else if let detailArray = viewModel.detailBook?.description as? [String: String] {
                        Text(detailArray["value"] ?? "No description")
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 14)
                    }
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomNavButton(image: Self.backButtonIbage,
                                                         action: { presentationMode.wrappedValue.dismiss() }),
                                trailing: user.userIsAuthorized
                                ? CustomNavButton(image: Self.likeButtonImage,
                                                  action: { addToLikeTapped() })
                                : nil
            )
            .padding()
            .preferredColorScheme(viewModel.isLightTheme ? .light : .dark)
            .onAppear {
                viewModel.fetchDetailBook(id: keyBook)
                viewModel.fetchRatingBook(id: keyBook)
            }
            .onDisappear {
                if let detailBook = viewModel.detailBook {
                    print("Print DETAIL - \(detailBook)")
                    coreData.addBook(book: detailBook, iaBook: iaBook, authorName: authorName)
//                    print("SavedRecentBooks - \(coreData.savedRecentBooks)")
                }
//                sleep(2)
                viewModel.ratingBook = nil
                viewModel.detailBook = nil
                print("SavedRecentBooks - \(coreData.savedRecentBooks)")
                coreData.fetchRecentBooks()
            }
        }
    }

    private func addToLikeTapped() {
        print(#function)
        user.fireBaseWrite(addToFavorite: viewModel.detailBook?.title ?? "No book name",
                           bookCode: keyBook)
    }

    private func openWebView() {
        isWebViewPresented = true
    }
}

#Preview {
    let viewModel = BookAppViewModel()
    return ProductView(keyBook: "keyBook", iaBook: "iaBook", authorName: "authorName")
        .environmentObject(viewModel)
}

struct CustomNavButton: View {

    @State var changeLikedState: Bool = false

    let image: String
    let action: () -> ()

    var body: some View {
        Button(action: {
            if image == ProductView.likeButtonImage { changeLikedState.toggle() }
            action()
        }) {
            Image(systemName: checkImage())
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(.black)
        }
    }

    func checkImage() -> String {
        image == ProductView.likeButtonImage ? (changeLikedState ? (ProductView.likeButtonImageFill) : (ProductView.likeButtonImage)): (image)
    }
}
