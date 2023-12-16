//
//  AccountListNavigationBarView.swift
//  BookStoreApp
//
//  Created by Андрей Бородкин on 14.12.2023.
//

import SwiftUI

struct AccountListNavigationBarView: View {
    
    var title: String
    var buttonAction: () -> ()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ViewBuilder items
    @ViewBuilder private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.primary)
        }
    }
    
    @ViewBuilder private var addListButton: some View {
        Button {
            self.buttonAction()
        } label: {
            Image(systemName: "plus")
                .foregroundColor(.primary)
        }
    }
    
    // MARK: - View Body
    var body: some View {
        HStack {
            backButton
            
            Spacer()
            
            Text(title)
                .font(Font.custom("Open Sans", size: 16))
                .fontWeight(.bold)
            Spacer()
            addListButton
        }
        .padding()
    }
}

//#Preview {
//    AccountListNavigationBarView(title: "TestTitle", buttonAction: () -> ())
//}
