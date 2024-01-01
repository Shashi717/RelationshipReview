//
//  PromptsViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/10/23.
//

import FirebaseAuth
import Foundation
import SwiftUI

// This VM represents a set of questions to be presented to the user
@Observable class PromptsViewModel {
    private let networkClient: NetworkClient
    private let relationship: Relationship
    let user: User?
    var prompts: [PromptViewModel]?
    
    var isCompleted: Bool {
        if let prompts = prompts {
            for prompt in prompts {
                if !prompt.isCompleted {
                    return false
                }
            }
        }
        return true
    }
    
    var excludedPromptTypes: Set<PromptType> {
        return Set(relationship.excludedPromptTypes.compactMap { type in
            switch type {
            case 0:
                return .general
            case 1:
                return .intimacy
            case 2:
                return .future
            default:
                return .unkown
            }
        })
    }
    
    init(networkClient: NetworkClient, prompts: [PromptViewModel]? = nil) {
        self.networkClient = networkClient
        self.prompts = prompts
        self.user = networkClient.getCurrentUser()
        // temp hard coded data
        self.relationship = Relationship(id: "1", partnerId: "2", communicationLevel: 0, relationshipStartDate: Date.now.description, excludedPromptTypes: [])
    }
    
    @MainActor
    func getPrompts() async {
        guard let prompts = await networkClient.fetchPrompts("prompts") else {
            return
        }
        let vm = prompts.compactMap { prompt in
            PromptViewModel(prompt: prompt)
        }
        self.prompts = vm.filter { prompt in
            !excludedPromptTypes.contains(prompt.type)
        }
    }
    
    func submitAnswers() {
        guard let prompts = prompts else {
            return
        }
        if isCompleted {
            let answers: [[String:String]] = prompts.map { [$0.promptId : $0.answer] }
            if saveAnswers(answers) {
                print("completed")
            }
        }
    }
    
    func saveAnswers(_ answers: [[String:String]]) -> Bool {
        let urlString = "https://www.google.com/"
        let answersToSubmit = AnswersToSubmit(userId: "0", partnerId: "1", date: Date.now.ISO8601Format(), answers: answers)
        return networkClient.submitPrompts(urlString, answersToSubmit)
    }
}
