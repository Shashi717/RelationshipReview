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
                Spacer()
                PromptView(promptViewModel: prompts[currentIndex])
                Spacer()
                HStack {
                    Button {
                        currentIndex -= 1
                    } label: {
                        Image(systemName: "arrowshape.backward.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .disabled(currentIndex == 0)
                    Spacer()
                    Button {
                        submit()
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 75, height: 75)
                    }
                    .disabled(!promptsViewModel.isCompleted)
                    .tint(.green)
                    Spacer()
                    Button {
                        currentIndex += 1
                    } label: {
                        Image(systemName: "arrowshape.forward.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .disabled(currentIndex == prompts.count - 1)
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
