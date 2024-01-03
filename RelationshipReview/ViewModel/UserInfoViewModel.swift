//
//  UserInfoViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 1/2/24.
//

import Foundation

@Observable class UserInfoViewModel {
    private let networkClient = NetworkClient()
    private var userInfo: UserInfo?
    var email: String? {
        networkClient.getCurrentUser()?.email
    }
    var userId: String? {
        networkClient.getCurrentUser()?.uid
    }
    var firstName: String {
        get {
            userInfo?.firstName ?? ""
        }
        set { }
    }
    var lastName: String {
        get {
            userInfo?.lastName ?? ""
        }
        set { }
    }
    var communicationLevel: CommunicationLevel {
        get {
            CommunicationLevel(rawValue: userInfo?.communicationLevel ?? 0) ?? .beginner
        }
        set { }
    }
    var partnerEmail: String {
        get {
            userInfo?.partnerEmail ?? ""
        }
        set { }
    }

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
