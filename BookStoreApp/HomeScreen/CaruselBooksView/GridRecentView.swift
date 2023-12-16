//
//  GridCaruselView.swift
//  BookStoreApp
//
//  Created by Daniil Kulikovskiy on 12/16/23.
//

import SwiftUI

struct GridRecentView: View {
    
    @ObservedObject var viewModel: CoreData
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.savedRecentBooks, id: \.self) { book in
                        RecentBookView(coreData: viewModel)
                    }
                }
                .padding(.horizontal, 5)
            }
            .background(.backgroundApp)
        }
    }
}


#Preview {
    GridRecentView(viewModel: CoreData())
}
