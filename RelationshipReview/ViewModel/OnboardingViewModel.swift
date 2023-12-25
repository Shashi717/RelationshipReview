//
//  OnboardingViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/2/23.
//

import FirebaseAuth
import Foundation

@Observable class OnboardingViewModel {
    var email: String = ""
    var password: String = ""
    
    var isValid: Bool {
        return EmailHelper.isValidEmail(email) && password.count > 6
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    func login() async throws -> User?  {
        guard isValid else {
            return nil
        }
        if let user = await signin() {
            return user
        } else {
            return await signup()
        }
    }
    
    private func signin() async -> User? {
        return try? await NetworkClient().signin(email, password)
    }
    
    private func signup() async -> User? {
        return try? await NetworkClient().createNewUser(email, password)
    }
}
