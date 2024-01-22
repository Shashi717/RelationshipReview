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
    @State var userInfoViewModel: UserInfoViewModel
    var promptsViewModel: PromptsViewModel
    var reviewViewModel: ReviewViewModel
    @State var isLoggedIn = NetworkClient().getCurrentUser() != nil
    var body: some View {
        if isLoggedIn {
            TabView {
                NavigationStack {
                    if userInfoViewModel.relationshipId != nil {
                        MainView(promptsViewModel: promptsViewModel, reviewViewModel: reviewViewModel)
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    Text("Review")
                                        .font(.headline)
                                }
                            }
                    } else {
                        Text("Please Add Relationship Info")
                            .font(.title)
                    }

                }
                .tabItem {
                    Image(systemName: "house")
                }
                PastReviewsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                SettingsView(userInfoViewModel: $userInfoViewModel, isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
            }
            .onAppear {
                Task {
                    await userInfoViewModel.loadUserInfo()
                    if let relationshipId = userInfoViewModel.relationshipId {
                        await promptsViewModel.loadRelationship(id: relationshipId)
                    }
                }
            }
        } else {
            OnboardingView(onboardingViewModel: OnboardingViewModel(), isLoggedIn: $isLoggedIn)
        }
    }
}

#Preview {
    ContentView(userInfoViewModel: UserInfoViewModel(networkClient: NetworkClient()), promptsViewModel: MockData().mockPromptsViewModel, reviewViewModel: MockData().mockReviewViewModel)
}
