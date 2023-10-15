//
//  ContentView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
  var promptsViewModel: PrompstViewModel
  var reviewViewModel: ReviewViewModel? = nil
  @State var showReviewView = false

  var body: some View {
    VStack {
      if showReviewView {
//        CheckInView(checkInViewModel: <#T##CheckInViewModel#>)
      } else if let prompts = promptsViewModel.prompts, !prompts.isEmpty {
        PromptsView(promptsViewModel: promptsViewModel, showReviewView: showReviewView)
      } else {
        // Temp for debugging
        Button(action: {
          guard let path = Bundle.main.path(forResource: "sample_prompts", ofType: "json") else {
            return
          }
          Task {
            await promptsViewModel.getPrompts(path)
          }
        }, label: {
          Text("Retry")
        })
      }
    }
    .onAppear {
      Task.init() {
        guard let path = Bundle.main.path(forResource: "sample_prompts", ofType: "json") else {
          return
        }
        await promptsViewModel.getPrompts(path)
      }
    }
  }
}

#Preview {
  ContentView(promptsViewModel: MockData().mockPromptsViewModel)
}
