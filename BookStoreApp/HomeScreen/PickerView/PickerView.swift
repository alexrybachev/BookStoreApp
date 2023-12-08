//
//  PickerView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//


import SwiftUI

struct PickerView: View {
    
    @Binding var selectedIndex: Int
    @State private var currentIndex: Int = 0
    
    init(selectedIndex: Binding<Int>) {
        _selectedIndex = selectedIndex
        categoriesPicker.removeAll()
        categoriesPicker.append(Category(id: 0, title: "Today", selected: true))
        categoriesPicker.append(Category(id: 1, title: "This Week", selected: false))
        categoriesPicker.append(Category(id: 2, title: "This Month", selected: false))
        categoriesPicker.append(Category(id: 3, title: "This Year", selected: false))
        categoriesPicker.append(Category(id: 4, title: "All Times", selected: false))
    }
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollView in
                    HStack(spacing: 15) {
                        ForEach(categoriesPicker, id: \.self) { item in
                            if item.id == currentIndex {
                                Text(item.title)
                                    .bold()
                                    .padding(10)
                                    .layoutPriority(1)
                                    .border(.black)
                                    .background(.black)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            } else {
                                Text(item.title)
                                    .bold()
                                    .padding(10)
                                    .border(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .onTapGesture {
                                        withAnimation {
                                            currentIndex = item.id
                                            selectedIndex = currentIndex
                                            scrollView.scrollTo(item)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    PickerView(selectedIndex: .constant(0))
}
