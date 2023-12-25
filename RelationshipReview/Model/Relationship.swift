//
//  Relationship.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

struct Relationship {
    var id: String
    var partnerId: String
    var communicationLevel: Int
    var relationshipStartDate: String
    var excludedPromptTypes: Set<Int>
}
