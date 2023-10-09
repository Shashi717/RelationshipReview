//
//  CheckIn.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

struct Review {
  var id: String
  var date: String
  var answers: [CheckIn]
}

struct Prompt {
  var id: String
  var type: PromptType
  var description: String
  var relationshipLevel: CommunicationLevel
}

enum PromptType {
  case intimacy
  case general
}

struct CheckIn {
  var id: String
  var promptId: String
  var answer: String
  var markedAsDiscussion: Bool
}
