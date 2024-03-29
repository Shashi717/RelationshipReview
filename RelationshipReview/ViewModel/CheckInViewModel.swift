//
//  CheckInViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import UIKit

// Represents each question with the answers from user and their partner
class CheckInViewModel {
    private let checkIn: CheckIn
    
    var id: String {
        checkIn.id ?? ""
    }
    var prompt: Prompt? {
        return getPrompt(checkIn.promptId)
    }
    var question: String {
        return prompt?.description ?? ""
    }
    var answer: String {
        checkIn.answer
    }
    var partnerAnswer: String {
        checkIn.partnerAnswer
    }
    var markedAsDiscussion: Bool {
        checkIn.markedAsDiscussion
    }
    
    private func getPrompt(_ id: String) -> Prompt? {
        return nil
    }
    
    init(checkIn: CheckIn) {
        self.checkIn = checkIn
    }
}
