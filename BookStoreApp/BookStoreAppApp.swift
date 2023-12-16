//
//  BookStoreAppApp.swift
//  BookStoreApp
//
//  Created by Aleksandr Rybachev on 07.12.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BookStoreAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @StateObject private var viewModel = BookAppViewModel()
    @StateObject private var user = User()
    
    @StateObject private var dataController = CoreData()
    
    var appearanceSwitch: ColorScheme? {
        viewModel.isLightTheme ? .light : .dark
    }

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView(viewModel: viewModel)
            } else {
                TabBarView(viewModel: viewModel, data: dataController)
                    .environmentObject(viewModel)
                    .environmentObject(user)
                    .environmentObject(dataController)
            }
        }
    }
}
