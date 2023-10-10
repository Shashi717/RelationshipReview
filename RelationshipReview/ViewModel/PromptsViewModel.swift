//
//  PromptsViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

class PrompstViewModel: ObservableObject {
  let prompts: [PromptViewModel]

  var isCompleted: Bool {
    for prompt in prompts {
      if !prompt.isCompleted {
        return false
      }
    }
    return true
  }

  init(prompts: [PromptViewModel]) {
    self.prompts = prompts
  }

  func submitAnswers() {
    if isCompleted {
      let answers: [[String:String]] = prompts.map { [$0.promptId : $0.answer] }
    }
  }
}

struct AnswersToSubmit {
  var userId: String
  var partnerId: String
  var answers: [[String:String]]
}
