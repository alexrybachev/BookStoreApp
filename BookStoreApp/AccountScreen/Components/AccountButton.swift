//
//  AccountRowContainerView.swift
//  BookStoreApp
//
//  Created by Андрей Бородкин on 14.12.2023.
//

import SwiftUI

struct AccountButton: View {
    var displayText = ""
    
    var body: some View {
        HStack{
            Text(displayText)
                .font(Font.custom("Open Sans", size: 16))
            Spacer()
            Image(systemName: "arrow.forward")
                .font(Font.custom("Open Sans", size: 16))
        }
        .frame(width: 320, height: 36)
        .padding()
        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
        .cornerRadius(5)
    }
}

#Preview {
    AccountButton()
}
