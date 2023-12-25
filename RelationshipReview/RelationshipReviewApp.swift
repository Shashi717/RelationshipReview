//
//  RelationshipReviewApp.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct RelationshipReviewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let networkClient = NetworkClient()
            let promptsViewModel = PromptsViewModel(networkClient: networkClient)
            let reviewViewModel = ReviewViewModel(networkClient: networkClient)
            ContentView(promptsViewModel: promptsViewModel, reviewViewModel: reviewViewModel)
        }
    }
}
