//
//  Relationship.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import FirebaseFirestore

struct Relationship: Codable {
    @DocumentID var id: String?
    var partners: [String]?
    var communicationLevel: Int?
    var relationshipStartDate: String?
    var excludedPromptTypes: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case partners
        case communicationLevel = "communication_level"
        case relationshipStartDate = "relationship_start_date"
        case excludedPromptTypes = "excluded_prompt_types"
    }
}
