//
//  ContentView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import FirebaseAuth
import Foundation
import SwiftUI

struct ContentView: View {
    var promptsViewModel: PromptsViewModel
    var reviewViewModel: ReviewViewModel
    @State var isLoggedIn = NetworkClient().getCurrentUser() != nil
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                MainView(promptsViewModel: promptsViewModel, reviewViewModel: reviewViewModel)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            NavigationLink (destination: SettingsView(isLoggedIn: $isLoggedIn)) {
                                Image(systemName: "gearshape")
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink (destination: PastReviewsView()) {
                                Image(systemName: "list.bullet")
                            }
                        }
                    }
            } else {
                OnboardingView(onboardingViewModel: OnboardingViewModel(), isLoggedIn: $isLoggedIn)
            }
        }
    }
}

#Preview {
    ContentView(promptsViewModel: MockData().mockPromptsViewModel, reviewViewModel: MockData().mockReviewViewModel)
}
