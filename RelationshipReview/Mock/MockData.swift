//
//  MockData.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import Foundation

struct MockData {
  let mockCheckInViewModel = CheckInViewModel(checkIn: CheckIn(id: "1", promptId: "1", answer: "Great", partnerAnswer: "Not Great", markedAsDiscussion: true))
  let mockPromptViewModel1 = PromptViewModel(prompt: Prompt(id: "1", type: .general, description: "What's your rating 1?", communicationLevel: .beginner))
  let mockPromptViewModel2 = PromptViewModel(prompt: Prompt(id: "2", type: .general, description: "What's your rating 2?", communicationLevel: .beginner))
  let mockPromptViewModel3 = PromptViewModel(prompt: Prompt(id: "3", type: .general, description: "What's your rating 3?", communicationLevel: .beginner))
  let mockPromptsViewModel = PrompstViewModel(prompts: [PromptViewModel(prompt: Prompt(id: "1", type: .general, description: "What's your rating 1?", communicationLevel: .beginner)), PromptViewModel(prompt: Prompt(id: "2", type: .general, description: "What's your rating 2?", communicationLevel: .beginner)), PromptViewModel(prompt: Prompt(id: "3", type: .general, description: "What's your rating 3?", communicationLevel: .beginner))])
}
