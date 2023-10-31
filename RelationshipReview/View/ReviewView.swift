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
        CheckInView(checkInViewModel: answers[currentIndex]).padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
        HStack {
          // make sure index doesn't go out of bounds
          Button(action: {
            if currentIndex > 0 {
              currentIndex -= 1
            }
          }, label: {
            Text("Previous")
          }).buttonStyle(.bordered)

          Button(action: {
            if currentIndex < answers.count - 1 {
              currentIndex += 1
            }
          }, label: {
            Text("Next")
          }).buttonStyle(.bordered)

          Button(action: {
  //          if promptsViewModel.isCompleted {
  //            presentAlert = false
  //            promptsViewModel.submitAnswers()
  //            showReviewView = true
  //          } else {
  //            presentAlert = true
  //          }
          }, label: {
            Text("Done")
          }).buttonStyle(.bordered)
        }
      }
    }
  }
}
