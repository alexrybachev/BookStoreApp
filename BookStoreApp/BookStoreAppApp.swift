//
//  BookStoreAppApp.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 03.12.2023.
//

import SwiftUI

@main
struct BookStoreAppApp: App {
    var body: some Scene {
        WindowGroup {
            SwiftUITestScreen(image: "", networkAggregateModel: NetworkAggregateModel(), textinput: "")
        }
    }
}
