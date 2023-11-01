//
//  MockData.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

struct MockData {
  let mockReviewViewModel = ReviewViewModel(networkClient: NetworkClient(), review: Review(id: "123", date: "1698681926", answers: [
    CheckIn(id: "1", promptId: "1", answer: "Great", partnerAnswer: "Not Great", markedAsDiscussion: true),
    CheckIn(id: "2", promptId: "2", answer: "Great", partnerAnswer: "Not Great", markedAsDiscussion: false)
  ]))

  let mockCheckInViewModel = CheckInViewModel(checkIn:  CheckIn(id: "1", promptId: "1", answer: "Great", partnerAnswer: "Not Great", markedAsDiscussion: true))


  let mockPromptViewModel1 = PromptViewModel(prompt: Prompt(id: "1", type: 0, description: "What's your rating 1?", communicationLevel: 0))
  let mockPromptViewModel2 = PromptViewModel(prompt: Prompt(id: "2", type: 0, description: "What's your rating 2?", communicationLevel: 0))
  let mockPromptViewModel3 = PromptViewModel(prompt: Prompt(id: "3", type: 0, description: "What's your rating 3?", communicationLevel: 0))
  let mockPromptsViewModel = PromptsViewModel(networkClient: NetworkClient(), prompts: [PromptViewModel(prompt: Prompt(id: "1", type: 0, description: "What's your rating 1?", communicationLevel: 0)), PromptViewModel(prompt: Prompt(id: "2", type: 0, description: "What's your rating 2?", communicationLevel: 0)), PromptViewModel(prompt: Prompt(id: "3", type: 0, description: "What's your rating 3?", communicationLevel: 0))])
}
