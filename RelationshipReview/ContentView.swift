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
  
  var body: some View {
    VStack {
      if let prompts = promptsViewModel.prompts, !prompts.isEmpty {
        PromptsView(promptsViewModel: promptsViewModel)
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
