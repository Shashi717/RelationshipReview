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
    private var relationship: Relationship?
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
        guard let excludedPromptTypes = relationship?.excludedPromptTypes else {
            return []
        }
        return Set(excludedPromptTypes.compactMap { type in
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
    }
    
    @MainActor
    func loadPrompts() async {
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

    @MainActor
    func loadRelationship(id: String) async {
        do {
            self.relationship = try await networkClient.fetchRelationship(id)
        } catch {
            print(error)
        }
    }

    func submitAnswers() async {
        guard let prompts = prompts,
              let relationshipId = relationship?.id,
              isCompleted else {
            return
        }
        let answers: [String:String] = prompts.reduce(into: [String: String]()) { result, promptVM in
            result[promptVM.id] = promptVM.answer
        }
        let checkin: [String:Any] = [
            "data" :
                [["date": Date.now.ISO8601Format(),
                  "answers": ["answer": answers]]]
        ]
        let checkin2: [String:Any] = [
            "data" : [
                "answers": [["partner_answer": answers]
                           ]]
        ]
        do {
            try await networkClient.submitCheckin(relationshipId, checkin, checkin2)
        } catch {
            print(error)
        }
        
    }
}
