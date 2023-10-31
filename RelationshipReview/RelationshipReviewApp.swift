//
//  RelationshipReviewApp.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

@main
struct RelationshipReviewApp: App {
    var body: some Scene {
        WindowGroup {
          let networkClient = NetworkClient()
          let promptsViewModel = PromptsViewModel(networkClient: networkClient)
          let reviewViewModel = ReviewViewModel(networkClient: networkClient)
          ContentView(promptsViewModel: promptsViewModel, reviewViewModel: reviewViewModel)
        }
    }
}
