//
//  MainView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/2/23.
//

import FirebaseFirestore
import SwiftUI

struct MainView: View {
    var promptsViewModel: PromptsViewModel
    var reviewViewModel: ReviewViewModel
    @State var showReviewView = false
    
    var body: some View {
        VStack {
            if showReviewView {
                ReviewView(reviewViewModel: reviewViewModel)
            } else if let prompts = promptsViewModel.prompts, !prompts.isEmpty {
                PromptsView(promptsViewModel: promptsViewModel, showReviewView: $showReviewView)
            }
        }
        .onAppear {
            Task.init() {
                await promptsViewModel.loadPrompts()
                //              await reviewViewModel.getReview(reviewPath)
            }
        }
    }
}

#Preview {
    MainView(promptsViewModel: MockData().mockPromptsViewModel, reviewViewModel: MockData().mockReviewViewModel)
}
