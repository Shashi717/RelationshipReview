//
//  Prompt.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/13/23.
//

import FirebaseFirestore

struct Prompt: Codable {
    @DocumentID var id: String?
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
