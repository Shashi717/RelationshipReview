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

struct NetworkClient {
    let networkService = NetworkService()
    let firebaseAuth = Auth.auth()
    
    func fetchPrompts(_ query: String) async -> [Prompt]? {
        let collectionReference = Firestore.firestore().collection(query)
        
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
    
    func submitPrompts(_ urlString: String, _ answers: AnswersToSubmit) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        // TODO: Submit to backend
        let data = try? JSONEncoder().encode(answers)
        UserDefaults.standard.setValue(data, forKey: "Submitted")
        return true
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
    
    func updateUserInfo(_ userId: String, _ userInfo: [String: Any]) async throws {
        let collectionReference = Firestore.firestore().collection("userInfo").document(userId)
        try await collectionReference.setData(userInfo, merge: true)
    }
}
