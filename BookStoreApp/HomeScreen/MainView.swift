//
//  MainView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: BookAppViewModel
    @ObservedObject var coreData: CoreData
    
    @State var seeMoreTop: Bool = true
    @State var seeMoreRecent: Bool = true
    
    var body: some View {
        VStack {
            VStack {
                TitleView(text: "Top Books", 
                          seeMore: $seeMoreTop)
                
                if viewModel.isLightTheme {
                    PickerView(viewModel: viewModel)
                } else {
                    PickerViewDarkTheme(viewModel: viewModel)
                }
                
                if seeMoreTop {
                    if viewModel.topTrends.isEmpty {
                        SkeletonView()
                    } else {
                        withAnimation {
                            CaruselBooksView(viewModel: viewModel)
                        }
                    }
                } else {
                    GridBooksView(viewModel: viewModel)
                }
            }
            
            VStack {
                TitleView(text: "Recent Books", seeMore: $seeMoreRecent)
                
if seeMoreRecent {
                    CaruselRecentBooks(coreData: coreData)
                } else {
                    GridRecentView(viewModel: coreData)
                }
            }
        }
        .onAppear {
            viewModel.searchBooksList = []
            coreData.fetchRecentBooks()
        }
    }
        
}

#Preview {
    MainView(viewModel: BookAppViewModel(), coreData: CoreData())
}
