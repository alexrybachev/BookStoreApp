//
//  HomeView.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    @State private var searchText = ""
    
    @FocusState var isFocused: Bool
    
   // @State private var showingAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            NavigationView {
                ScrollView(showsIndicators: false) {
     
                    HStack {
                        SearchView(searchText: $searchText,
                                   viewModel: viewModel,
                                   focusField: $isFocused)
                        
                        if !searchText.isEmpty {
                            Button {
                            
                                viewModel.fetchSearchBooks(query: searchText)
                                isFocused = false
                                
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(viewModel.isLightTheme ? .black : .gray)
                                    .frame(width: 56, height: 56)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(4)
                            }
//                            .alert("Пустое поле", isPresented: $showingAlert) {
//                                    Button("Ok", role: .cancel) { }
//                                } message: {
//                                    Text("Напишите запрос для поиска")
//                                }
                            
                        }
                            
                    }
                    .animation(.bouncy, value: searchText)
   
                    if searchText.isEmpty {
                        MainView(viewModel: viewModel)
                    } else {
                        EmptyViewSearch(query: $searchText, viewModel: viewModel)
                    }
                }
                .onTapGesture {
                    isFocused = false
                }
                .padding()
            }
            .task {
                withAnimation{
                    viewModel.fetchTrendsBooks()
                }
            }
        }
        .preferredColorScheme(viewModel.isLightTheme ? .light : .dark)
    }
    
    func clearSearchList() {
        viewModel.searchBooksList = []
    }

}

#Preview {
    HomeView(viewModel: BookAppViewModel())
}
