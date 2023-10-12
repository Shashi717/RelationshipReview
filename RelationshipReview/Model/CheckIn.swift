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

struct Prompt: Codable {
  var id: String
  var type: Int
  var description: String
  var communicationLevel: Int

  enum CodingKeys: String, CodingKey {
    case id
    case type
    case description
    case communicationLevel = "communication_level"
  }
}

enum PromptType {
  case general
  case intimacy
  case marriage
  case unkown
}

struct CheckIn: Codable {
  var id: String
  var promptId: String
  var answer: String
  var partnerAnswer: String
  var markedAsDiscussion: Bool

  enum CodingKeys: String, CodingKey {
    case id
    case promptId = "prompt_id"
    case answer
    case partnerAnswer = "partner_answer"
    case markedAsDiscussion = "marked_as_discussion"
  }
}
