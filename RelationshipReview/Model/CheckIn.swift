//
//  CheckIn.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

struct Review {
  var id: String
  var date: String
  var answers: [CheckIn]
}

struct Prompt {
  var id: String
  var type: PromptType
  var description: String
  var communicationLevel: CommunicationLevel
}

enum PromptType {
  case general
  case intimacy
  case marriage
}

struct CheckIn {
  var id: String
  var promptId: String
  var answer: String
  var partnerAnswer: String
  var markedAsDiscussion: Bool
}
