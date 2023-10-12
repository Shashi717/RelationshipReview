//
//  MockData.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

struct MockData {
  let mockCheckInViewModel = CheckInViewModel(checkIn: CheckIn(id: "1", promptId: "1", answer: "Great", partnerAnswer: "Not Great", markedAsDiscussion: true))
  let mockPromptViewModel1 = PromptViewModel(prompt: Prompt(id: "1", type: 0, description: "What's your rating 1?", communicationLevel: 0))
  let mockPromptViewModel2 = PromptViewModel(prompt: Prompt(id: "2", type: 0, description: "What's your rating 2?", communicationLevel: 0))
  let mockPromptViewModel3 = PromptViewModel(prompt: Prompt(id: "3", type: 0, description: "What's your rating 3?", communicationLevel: 0))
  let mockPromptsViewModel = PrompstViewModel(networkClient: NetworkClient(), prompts: [PromptViewModel(prompt: Prompt(id: "1", type: 0, description: "What's your rating 1?", communicationLevel: 0)), PromptViewModel(prompt: Prompt(id: "2", type: 0, description: "What's your rating 2?", communicationLevel: 0)), PromptViewModel(prompt: Prompt(id: "3", type: 0, description: "What's your rating 3?", communicationLevel: 0))])
}
