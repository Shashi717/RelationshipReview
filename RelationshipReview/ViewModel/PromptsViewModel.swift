//
//  PromptsViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

// This VM represents a set of questions to be presented to the user
class PrompstViewModel: ObservableObject {
  private let networkClient: NetworkClient
  private let relationship: Relationship
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

  var excludedPromptTypes: Set<PromptType> {
    return Set(relationship.excludedPromptTypes.compactMap { type in
      switch type {
      case 0:
        return .general
      case 1:
        return .intimacy
      case 2:
        return .marriage
      default:
        return .unkown
      }
    })
  }

  init(networkClient: NetworkClient, prompts: [PromptViewModel]? = nil) {
    self.networkClient = networkClient
    self.prompts = prompts
    // temp hard coded data
    self.relationship = Relationship(id: "1", partnerId: "2", communicationLevel: 0, relationshipStartDate: Date.now.description, excludedPromptTypes: [2])
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
      !excludedPromptTypes.contains(prompt.type)
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
