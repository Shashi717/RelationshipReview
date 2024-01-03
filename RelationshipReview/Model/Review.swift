//
//  Review.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/13/23.
//

import FirebaseFirestore

struct Review: Codable {
    @DocumentID var id: String?
    var date: String
    var answers: [CheckIn]
}

