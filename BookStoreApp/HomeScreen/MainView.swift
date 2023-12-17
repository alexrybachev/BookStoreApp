//
//  MainView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: BookAppViewModel
    @EnvironmentObject var coreData: CoreData
    
    @State var seeMoreTop: Bool = true
    @State var seeMoreRecent: Bool = true
    
    var body: some View {
        VStack {
            VStack {
                TitleView(text: "Top Books", 
                          seeMore: $seeMoreTop)
                
                if viewModel.isLightTheme {
                    PickerView()
                } else {
                    PickerViewDarkTheme()
                }
                
                if seeMoreTop {
                    if viewModel.topTrends.isEmpty {
                        SkeletonView()
                    } else {
                        withAnimation {
                            CaruselBooksView()
                        }
                    }
                } else {
                    GridBooksView()
                }
            }
            
            VStack {
                TitleView(text: "Recent Books", seeMore: $seeMoreRecent)
                
                if seeMoreRecent {
                    CaruselRecentBooks()
                } else {
                    GridRecentView()
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
    MainView()
}
