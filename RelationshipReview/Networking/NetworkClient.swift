//
//  NetworkClient.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/2/23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class NetworkClient {
    let networkService = NetworkService()
    let firebaseAuth = Auth.auth()
    let firestore = Firestore.firestore()



    func fetchPrompts(_ query: String) async -> [Prompt]? {
        let collectionReference = firestore.collection(query)

        do {
            let querySnapshot = try await collectionReference.getDocuments()
            let prompts = try? querySnapshot.documents.compactMap { document -> Prompt? in
                return try document.data(as: Prompt.self)
            }
            return prompts
        } catch {
            print(error)
        }
        return nil
    }

    func fetchReview(_ urlString: String) async -> Review? {
        guard let url = URL(string: urlString),
              let data = await networkService.fetchData(url) else {
            return nil
        }
        return try? JSONDecoder().decode(Review.self, from: data)
    }

    func markAsDiscussion(_ urlString: String, _ id: String) async -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        // TODO: Submit to backend
        return true
    }

    func fetchImage(_ urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString),
              let data = await networkService.fetchData(url) else {
            return nil
        }
        return UIImage(data: data)
    }

    func fetchPastReviews(_ userId: String) async throws -> [Review] {
        let collectionReference = firestore.collection("reviews/\(userId)")
        let querySnapshot = try await collectionReference.getDocuments()
        let reviews = try querySnapshot.documents.compactMap { document -> Review? in
            return try document.data(as: Review.self)
        }
        return reviews
    }

    func submitCheckin(_ userId: String, _ answers: [String: Any], _ partnerAnswers: [String:Any]) async throws {
        let collectionReference1 = firestore.collection("reviews")
        try await collectionReference1.document(userId).setData(answers, merge: true)
        try await collectionReference1.document("partnerUserId").setData(partnerAnswers, merge: true)
    }
}

// MARK: UserInfo

extension NetworkClient {

    func fetchUserInfo(_ email: String) async throws -> UserInfo {
        let collectionReference = firestore.collection("userInfo").document(email)
        let querySnapshot = try await collectionReference.getDocument()
        let userInfo = try querySnapshot.data(as: UserInfo.self)
        return userInfo
    }

    func updateUserInfo(_ email: String, _ userInfo: [String: Any]) async throws {
        let collectionReference = firestore.collection("userInfo").document(email)
        try await collectionReference.setData(userInfo, merge: true)
    }
}

// MARK: Signin/ Signup

extension NetworkClient {
    func createNewUser(_ email: String, _ password: String) async throws
    -> User {
        let result = try await firebaseAuth.createUser(withEmail: email, password: password)
        return result.user
    }

    func signin(_ email: String, _ password: String) async throws
    -> User {
        let result = try await firebaseAuth.signIn(withEmail: email, password: password)
        return result.user
    }

    func signout() throws {
        try firebaseAuth.signOut()
    }

    func getCurrentUser() -> User? {
        return firebaseAuth.currentUser
    }
}
