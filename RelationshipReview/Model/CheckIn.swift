//
//  CheckIn.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

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
