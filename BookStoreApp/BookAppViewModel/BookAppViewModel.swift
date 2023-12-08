//
//  BookAppViewModel.swift
//  BookStoreApp
//
//  Created by Alex on 07.12.2023.
//

import SwiftUI

class BookAppViewModel: ObservableObject {

    @AppStorage("appearanceSelection") var isLightThemeStorage: Bool = true

    var isLightTheme: Bool {
        get { isLightThemeStorage }
        set { isLightThemeStorage = newValue }
    }

}
