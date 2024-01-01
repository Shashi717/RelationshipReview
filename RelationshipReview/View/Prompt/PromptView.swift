//
//  PromptView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

// View for each prompt (question) with a space to answer
struct PromptView: View {
    @Bindable var promptViewModel: PromptViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(promptViewModel.description)
            TextField("Enter your answer here", text: $promptViewModel.answer, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        .background(Gradient.backgroundColor(promptViewModel.type))
        .clipShape(.rect(cornerSize: CGSize(width: 15, height: 15)))
    }
}

#Preview {
    PromptView(promptViewModel: MockData().mockPromptViewModel1)
}

