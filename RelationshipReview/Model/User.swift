//
//  User.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

struct User {
  var id: String
  var username: String
  var firstName: String
  var lastName: String?
  var email: String
  var gender: Gender
  var sexualOrientation: SexualOrientation
  var profileImageURL: String?
  var relationshipId: String
}
