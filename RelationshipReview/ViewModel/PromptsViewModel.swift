//
//  PromptsViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

class PrompstViewModel: ObservableObject {
  var prompts: [PromptViewModel]
  let relationship: Relationship

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
    self.relationship = Relationship(id: "1", partnerId: "2", communicationLevel: .beginner, relationshipStartDate: Date.now.description, excludedPromptTypes: [.marriage])
  }

  func getPrompts() {
    let prompts: [PromptViewModel] = []
    self.prompts = prompts.filter { prompt in
      !relationship.excludedPromptTypes.contains(prompt.type)
    }
  }

  func submitAnswers() {
    if isCompleted {
      let answers: [[String:String]] = prompts.map { [$0.promptId : $0.answer] }
      print("completed")
    }
  }
}

struct AnswersToSubmit {
  var userId: String
  var partnerId: String
  var answers: [[String:String]]
}
