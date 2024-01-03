//
//  PromptsView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/13/23.
//

import Foundation
import SwiftUI

struct PromptsView: View {
    var promptsViewModel: PromptsViewModel
    @State var currentIndex = 0
    @Binding var showReviewView: Bool
    
    var body: some View {
        if let prompts = promptsViewModel.prompts, !prompts.isEmpty {
            VStack {
                Button("", systemImage: "checkmark.circle") {
                    submit()
                }
                .disabled(!promptsViewModel.isCompleted)
                .tint(.green)
                HStack {
                    Button("", systemImage: "arrowshape.backward.circle") {
                        currentIndex -= 1
                    }
                    .disabled(currentIndex == 0)
                    .tint(.green)
                    PromptView(promptViewModel: prompts[currentIndex])
                    Button("", systemImage: "arrowshape.forward.circle") {
                        currentIndex += 1
                    }
                    .disabled(currentIndex == prompts.count - 1)
                    .tint(.green)
                }
            }
            .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        }
    }
    
    private func submit() {
        Task {
            await promptsViewModel.submitAnswers()
            showReviewView = true
        }
    }
}

#Preview {
    PromptsView(promptsViewModel: MockData().mockPromptsViewModel, showReviewView: .constant(false))
}
