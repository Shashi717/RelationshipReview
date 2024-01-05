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
        if isLoggedIn {
            TabView {
                NavigationStack {
                    MainView(promptsViewModel: promptsViewModel, reviewViewModel: reviewViewModel)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Text("Review")
                                    .font(.headline)
                            }
                        }
                }
                .tabItem {
                    Image(systemName: "house")
                }
                PastReviewsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                SettingsView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
            }
        } else {
            OnboardingView(onboardingViewModel: OnboardingViewModel(), isLoggedIn: $isLoggedIn)
        }
    }
}

#Preview {
    ContentView(promptsViewModel: MockData().mockPromptsViewModel, reviewViewModel: MockData().mockReviewViewModel)
}
