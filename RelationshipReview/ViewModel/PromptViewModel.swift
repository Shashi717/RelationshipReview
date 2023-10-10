//
//  PromptViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

class PromptViewModel: ObservableObject {
  private let prompt: Prompt
  @Published var answer: String
  var promptId: String {
    prompt.id
  }
  var description: String {
    prompt.description
  }
  var isCompleted: Bool {
    !answer.isEmpty
  }
  var type: PromptType {
    prompt.type
  }

  init(prompt: Prompt) {
    self.prompt = prompt
    self.answer = ""
  }
}
