//
//  AnswersToSubmit.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/15/23.
//

struct AnswersToSubmit: Codable {
    var userId: String
    var partnerId: String
    var date: String
    var answers: [String:String]
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case partnerId = "partner_id"
        case date
        case answers
    }
}
