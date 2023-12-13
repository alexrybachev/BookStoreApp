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

    @State private var isWebViewPresented = false
    
    let keyBook: String
    let iaBook: String
    let authorName: String
    
    var isUserLoggedIn = true
    // static data
    static let backButtonIbage = "arrow.backward"
    static let likeButtonImage = "heart"
    static let likeButtonImageFill = "heart.fill"
    static let descriptionText = "Description:"
//    // mock data
//    let bookNameText = MockDataProductView.bookNameText
//    let webViewURL = MockDataProductView.webViewURL
//    let title = MockDataProductView.navTitle
//    let fullDescriptionText = MockDataProductView.fullDescriptionText

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            VStack {
                Text(viewModel.detailBook?.title ?? "No name")
                    .font(.system(size: 24, weight: .semibold))
                
                // Перенести на экран настроек - start
                Button(action: {
                    viewModel.isLightTheme.toggle()
                }) {
                    Text("Toggle Mode")
                }
                // - end
                
                PictureTextView(
                    coverId: String(viewModel.detailBook?.covers?.first ?? 0),
                    authorName: authorName,
                    category: viewModel.detailBook?.subjectNames ?? "No categories"
                ) {
                    openWebView()
                }
                .padding(.top, 16)
//                .sheet(isPresented: $isWebViewPresented) {
//                    WebView(urlString: book.readUrl)
//                }
                
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
//            .navigationTitle(viewModel.detailBook?.title ?? "No name")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: CustomNavButton(image: Self.backButtonIbage, action: {
                    presentationMode.wrappedValue.dismiss()
                }),
                trailing: isUserLoggedIn ?
                CustomNavButton(image: Self.likeButtonImage, action: {
                    addToLikeTapped()
                }) : nil
            )
            NavigationLink(
                destination: WebView(urlString: iaBook),
                isActive: $isWebViewPresented
            ) {
                EmptyView()
            }
            .padding()
            .preferredColorScheme(viewModel.isLightTheme ? .light : .dark)
            .onAppear {
                viewModel.fetchDetailBook(id: keyBook)
            }
        }
    }

    private func addToLikeTapped() {
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
    let action: ()->()

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

    func checkImage()-> String {
        image == ProductView.likeButtonImage ? (changeLikedState ? (ProductView.likeButtonImageFill) : (ProductView.likeButtonImage)): (image)
    }
}
