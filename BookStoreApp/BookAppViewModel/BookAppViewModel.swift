//
//  BookAppViewModel.swift
//  BookStoreApp
//
//  Created by Alex on 07.12.2023.
//

import SwiftUI

class BookAppViewModel: ObservableObject {

    @AppStorage("appearanceSelection") var appearanceSelection: Bool = true

    var changeApperance: Bool {
        get { appearanceSelection }
        set { appearanceSelection = newValue }
    }

}
