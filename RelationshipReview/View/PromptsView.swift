//
//  PromptsView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/13/23.
//

import Foundation
import SwiftUI

struct PromptsView: View {
  var promptsViewModel: PromptsViewModel
  @State var currentIndex = 0
  @Binding var showReviewView: Bool
  
  var body: some View {
    VStack {
      if let prompts = promptsViewModel.prompts, !prompts.isEmpty {
        PromptView(promptViewModel: prompts[currentIndex]).padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        HStack {
          // make sure index doesn't go out of bounds
          Button(action: {
            currentIndex -= 1
          }, label: {
            Text("Previous")
          }).buttonStyle(.bordered)
            .disabled(currentIndex == 0)
          
          Button(action: {
            currentIndex += 1
          }, label: {
            Text("Next")
          }).buttonStyle(.bordered)
            .disabled(currentIndex == prompts.count - 1)
          
          Button(action: {
            promptsViewModel.submitAnswers()
            showReviewView = true
          }, label: {
            Text("Submit")
          }).buttonStyle(.bordered)
            .disabled(!promptsViewModel.isCompleted)
        }
      }
    }
  }
}

#Preview {
  PromptsView(promptsViewModel: MockData().mockPromptsViewModel, showReviewView: .constant(false))
}
