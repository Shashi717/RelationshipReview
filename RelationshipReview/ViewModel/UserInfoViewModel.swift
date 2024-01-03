//
//  UserInfoViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 1/2/24.
//

import Foundation

@Observable class UserInfoViewModel {
    private let networkClient = NetworkClient()

    private var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else {
                return
            }
            firstName = userInfo.firstName
            lastName = userInfo.lastName
            communicationLevel = CommunicationLevel(rawValue: userInfo.communicationLevel) ?? .beginner
            partnerEmail = userInfo.partnerEmail
        }
    }
    var email: String? {
        networkClient.getCurrentUser()?.email
    }
    var userId: String? {
        networkClient.getCurrentUser()?.uid
    }
    var firstName: String = ""
    var lastName: String = ""
    var communicationLevel: CommunicationLevel = .beginner
    var partnerEmail: String = ""

    init() { }

    func loadUserInfo() async {
        guard let email = email else {
            return
        }
        do {
            userInfo = try await networkClient.fetchUserInfo(email)
        } catch {
            print(error)
        }
    }

    func updateUserInfo() async {
        guard EmailHelper.isValidEmail(partnerEmail),
              !firstName.isEmpty,
              !lastName.isEmpty,
              let userId = userId,
              let email = email else {
            return
        }

        let userInfo: [String: Any] = [
            "user_id": userId,
            "first_name": firstName,
            "last_name": lastName,
            "communication_level": communicationLevel.rawValue,
            "partner_email": partnerEmail
        ]
        // network request to add partner email
        do {
            try await networkClient.updateUserInfo(email, userInfo)
        } catch {
            print(error)
        }
    }
}
