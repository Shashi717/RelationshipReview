//
//  Review.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/13/23.
//

struct Review: Codable {
    var id: String
    var date: String
    var answers: [CheckIn]
}
