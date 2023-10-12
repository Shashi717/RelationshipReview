//
//  PromptsViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

class PrompstViewModel: ObservableObject {
  private let networkClient: NetworkClient
  let relationship: Relationship
  @Published var prompts: [PromptViewModel]?

  var isCompleted: Bool {
    if let prompts = prompts {
      for prompt in prompts {
        if !prompt.isCompleted {
          return false
        }
      }
    }
    return true
  }

  init(networkClient: NetworkClient, prompts: [PromptViewModel]? = nil) {
    self.networkClient = networkClient
    self.prompts = prompts
    self.relationship = Relationship(id: "1", partnerId: "2", communicationLevel: .beginner, relationshipStartDate: Date.now.description, excludedPromptTypes: [.marriage])
  }

  @MainActor
  func getPrompts(_ urlString: String) async {
    guard let prompts = await networkClient.fetchPrompts(urlString) else {
      return
    }
    let vm = prompts.compactMap { prompt in
      PromptViewModel(prompt: prompt)
    }
    self.prompts = vm.filter { prompt in
      !relationship.excludedPromptTypes.contains(prompt.type)
    }
  }

  func submitAnswers() {
    guard let prompts = prompts else {
      return
    }
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
