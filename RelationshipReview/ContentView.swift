//
//  ContentView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
  @ObservedObject var promptsViewModel: PrompstViewModel
  @State var currentIndex = 0
  @State var presentAlert = false

  var body: some View {
    VStack {
      PromptView(promptViewModel: promptsViewModel.prompts[currentIndex]).padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))

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
          if currentIndex < promptsViewModel.prompts.count - 1 {
            currentIndex += 1
          }
        }, label: {
          Text("Next")
        }).buttonStyle(.bordered)
        
        Button(action: {
          if promptsViewModel.isCompleted {
            presentAlert = false
            promptsViewModel.submitAnswers()
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

#Preview {
  ContentView(promptsViewModel: MockData().mockPromptsViewModel)
}
