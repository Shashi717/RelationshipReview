//
//  PromptView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

struct PromptView: View {
  @ObservedObject var promptViewModel: PromptViewModel
  var body: some View {
    VStack {
      Text(promptViewModel.description)
      TextField("Enter your answer here", text: $promptViewModel.answer).textFieldStyle(.roundedBorder)
    }
  }
}

