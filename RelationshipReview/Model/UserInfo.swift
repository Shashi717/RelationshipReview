//
//  UserInfo.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation
import FirebaseFirestore

struct UserInfo: Codable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var partnerEmail: String
    var communicationLevel: Int
    var gender: Int?
    var sexualOrientation: Int?
    var profileImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case partnerEmail = "partner_email"
        case communicationLevel = "communication_level"
        case gender
        case sexualOrientation = "sexual_orientation"
        case profileImageURL = "profile_image_url"
    }
}
