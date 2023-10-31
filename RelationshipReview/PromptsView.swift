//
//  PromptsView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/13/23.
//

import Foundation
import SwiftUI

struct PromptsView: View {
  var promptsViewModel: PrompstViewModel
  @State var currentIndex = 0
  @State var presentAlert = false
  @Binding var showReviewView: Bool

  var body: some View {
    VStack {
      if let prompts = promptsViewModel.prompts, !prompts.isEmpty {
        PromptView(promptViewModel: prompts[currentIndex]).padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        HStack {
          // make sure index doesn't go out of bounds
          Button(action: {
            if currentIndex > 0 {
              currentIndex -= 1
            }
          }, label: {
            Text("Previous")
          }).buttonStyle(.bordered)

          Button(action: {
            if currentIndex < prompts.count - 1 {
              currentIndex += 1
            }
          }, label: {
            Text("Next")
          }).buttonStyle(.bordered)

          Button(action: {
            if promptsViewModel.isCompleted {
              presentAlert = false
              promptsViewModel.submitAnswers()
              showReviewView = true
            } else {
              presentAlert = true
            }
          }, label: {
            Text("Submit")
          }).buttonStyle(.bordered)
        }
        .alert("Please complete all the prompts", isPresented: $presentAlert, actions: {})
      }
    }
  }
}
