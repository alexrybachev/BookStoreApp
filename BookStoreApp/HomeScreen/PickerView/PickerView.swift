//
//  PickerView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//


import SwiftUI

struct PickerView: View {
    
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
                            viewModel.fetchTrendsBooks()
                        }) {
                            Text(trend.rawValue)
                                .bold()
                                .padding(10)
                                .foregroundStyle(selectedTrend == trend ? .white : .black)
                                .background(selectedTrend == trend ? .black : .clear)
                                .border(selectedTrend == trend ? .clear : .black)
                            // .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
    PickerView(viewModel: BookAppViewModel())
}
