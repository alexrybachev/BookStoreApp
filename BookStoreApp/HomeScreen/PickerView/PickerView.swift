//
//  PickerView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//


import SwiftUI

var Categories: [Category] = []
var lastIndex: Int = 0

struct Category: Hashable {
    let id: Int
    var title: String
    var selected: Bool
    
    init (id: Int, title: String, selected: Bool) {
        self.id = id
        self.title = title
        self.selected = selected
    }
}

struct CustomPickerView: View {
    
    @Binding var selectedIndex: Int
    @State private var currentIndex: Int = 0
    @Namespace private var ns
    
    init(selectedIndex: Binding<Int>) {
        _selectedIndex = selectedIndex
        Categories.removeAll()
        Categories.append(Category(id: 0, title: "Today", selected: true))
        Categories.append(Category(id: 1, title: "This Week", selected: false))
        Categories.append(Category(id: 2, title: "This Month", selected: false))
        Categories.append(Category(id: 3, title: "This Year", selected: false))
        Categories.append(Category(id: 4, title: "All Times", selected: false))
    }
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollView in
                    HStack(spacing: 25) {
                        ForEach(Categories, id: \.self) { item in
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
                                    .border(.yellow)
                                    .onTapGesture {
                                       // withAnimation {
                                            currentIndex = item.id
                                            selectedIndex = currentIndex
                                            scrollView.scrollTo(item)
                                        //}
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
    CustomPickerView(selectedIndex: .constant(0))
}
