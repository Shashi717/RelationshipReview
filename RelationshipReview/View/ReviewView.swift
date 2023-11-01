//
//  ReviewView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/15/23.
//

import SwiftUI

struct ReviewView: View {
  var reviewViewModel: ReviewViewModel
  @State var currentIndex = 0
  var body: some View {
    VStack {
      if let answers = reviewViewModel.answers,
         !answers.isEmpty  {
        Text("Date: \(reviewViewModel.dateString)")
        CheckInView(checkInViewModel: answers[currentIndex], profileImage: reviewViewModel.profileImage, partnerProfileImage: reviewViewModel.partnerProfileImage)
          .padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        HStack {
          // make sure index doesn't go out of bounds
          Button(action: {
            currentIndex -= 1
          }, label: {
            Text("Previous")
          }).buttonStyle(.bordered)
            .disabled(currentIndex == 0)

          Button(action: {
            currentIndex += 1
          }, label: {
            Text("Next")
          }).buttonStyle(.bordered)
            .disabled(currentIndex == answers.count - 1)

          Button(action: {
            guard let id = reviewViewModel.answers?[currentIndex].id else {
              return
            }
            Task {
              await reviewViewModel.markAsDiscussion(id)
            }
          }, label: {
            Text("Discuss")
          }).buttonStyle(.bordered)
        }
      }
    }
  }
}

#Preview {
  ReviewView(reviewViewModel: MockData().mockReviewViewModel)
}
