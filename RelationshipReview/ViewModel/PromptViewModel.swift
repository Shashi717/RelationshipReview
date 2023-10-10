//
//  PromptViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

class PromptViewModel: ObservableObject {
  private let prompt: Prompt
  var promptId: String
  @Published var answer: String
  var description: String {
    prompt.description
  }
  var isCompleted: Bool {
    !answer.isEmpty
  }

  init(prompt: Prompt) {
    self.prompt = prompt
    self.answer = ""
  }
}
