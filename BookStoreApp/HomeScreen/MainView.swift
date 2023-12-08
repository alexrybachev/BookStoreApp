//
//  MainView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedPicker = 1
    
    @State var seeMoreTop: Bool = true
    @State var seeMoreRecent: Bool = true
    
    var body: some View {
        VStack {
            VStack {
                TitleView(text: "Top Books", seeMore: $seeMoreTop)
                PickerView(selectedIndex: $selectedPicker)
                if seeMoreTop {
                    CaruselBooksView()
                } else {
                    GridBooksView()
                }
            }
            
            VStack {
                TitleView(text: "Recent Books", seeMore: $seeMoreRecent)
                
                if seeMoreRecent {
                    CaruselBooksView()
                } else {
                    GridBooksView()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
