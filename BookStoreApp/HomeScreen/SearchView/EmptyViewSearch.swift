//
//  EmptyView.swift
//  BookStoreApp
//
//  Created by MICHAIL SHAKHVOROSTOV on 07.12.2023.
//

import SwiftUI

struct EmptyViewSearch: View {
    
    @Binding var query: String
    
    var body: some View {
        Text("We searching \(query)")
    }
}

#Preview {
    EmptyViewSearch(query: .constant("asasd"))
}
