//
//  PickerViewDarkTheme.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 16.12.2023.
//

import SwiftUI

struct PickerViewDarkTheme: View {
    
    @ObservedObject var viewModel: BookAppViewModel
    @State private var selectedTrend: SortTrends = .daily
    
    private let trends = SortTrends.allCases
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(trends, id: \.self) { trend in
                        Button(action: {
                            selectedTrend = trend
                            viewModel.selectedTrend = trend
                            viewModel.topTrends = []
                            viewModel.fetchTrendsBooks()
                        }) {
                            Text(trend.rawValue)
                                .bold()
                                .padding(10)
                                .foregroundStyle(selectedTrend == trend ? .black.opacity(0.8) : .gray)
                                .background(selectedTrend == trend ? .gray : .clear)
                                .border(selectedTrend == trend ? .clear : .gray)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            selectedTrend = viewModel.selectedTrend
        }
    }
    
}

#Preview {
    PickerViewDarkTheme(viewModel: BookAppViewModel())
}
