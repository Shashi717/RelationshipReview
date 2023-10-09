//
//  PromptView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

struct PromptView: View {
  @State var promptViewModel: PromptViewModel
  var body: some View {
    VStack {
      Text(promptViewModel.description)
      TextField("", text: $promptViewModel.answer)
    }
  }
}

class PromptViewModel {
  private let prompt: Prompt

  var description: String {
    prompt.description
  }
  var answer: String

  init(prompt: Prompt) {
    self.prompt = prompt
    self.answer = ""
  }
}
