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
          let promptsViewModel = PrompstViewModel(networkClient: NetworkClient())
          ContentView(promptsViewModel: promptsViewModel)
        }
    }
}
