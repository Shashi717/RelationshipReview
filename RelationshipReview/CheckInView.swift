//
//  CheckInView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

// Not in use yet
struct CheckInView: View {
  let checkInViewModel: CheckInViewModel
  var body: some View {
    VStack {
      Text(checkInViewModel.question)
      AnswerView(answer: checkInViewModel.answer, profileImage: checkInViewModel.profileImage)
      AnswerView(answer: checkInViewModel.partnerAnswer, profileImage: checkInViewModel.partnerProfileImage)
      if checkInViewModel.markedAsDiscussion {
        Image(systemName: "flag.circle")
            .imageScale(.large)
            .foregroundStyle(.tint)
            .tint(.green)
      }
    }
  }
}

struct AnswerView: View {
  let answer: String
  let profileImage: UIImage?
  var body: some View {
    HStack {
      Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.tint)
          .tint(.green)
      Text(answer)
    }
  }
}
