//
//  UserInfoViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 1/2/24.
//

import Foundation

@Observable class UserInfoViewModel {
    private let networkClient: NetworkClient

    private var userInfo: UserInfo? {
        didSet {
            guard let userInfo = userInfo else {
                return
            }
            firstName = userInfo.firstName
            lastName = userInfo.lastName
            communicationLevel = CommunicationLevel(rawValue: userInfo.communicationLevel) ?? .beginner
            partnerEmail = userInfo.partnerEmail
            relationshipId = userInfo.relationshipId
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
    var relationshipId: String?

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

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

    @MainActor
    func createRelationship() async {
        let relationshipId = UUID().uuidString
        let userId = userId
        let partnerId = userId
        let communicationLevel = communicationLevel.rawValue
//        var relationshipStartDate: String
        let excludedPromptTypes = [0]
        guard EmailHelper.isValidEmail(partnerEmail),
              let partnerEmail = email else {
            return
        }

        let relatiosnship: [String: Any] = [
            "partners": [email, partnerEmail],
            "communication_level": communicationLevel,
            "excluded_prompt_types": excludedPromptTypes
        ]
        do {
            let success = try await networkClient.updateRelationship(relationshipId, relatiosnship)
            if success {
                try await updateUserInfoWithRelationship(relationshipId)
            }
        } catch {
            print(error)
        }
    }

    func updateUserInfoWithRelationship(_ id: String) async throws {
        guard EmailHelper.isValidEmail(partnerEmail),
        let email = email else {
            return
        }
        try await networkClient.updateUserInfoWithRelationship(email, id)
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
        do {
            try await networkClient.updateUserInfo(email, userInfo)
        } catch {
            print(error)
        }
    }
}
