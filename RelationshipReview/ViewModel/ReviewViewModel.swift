//
//  ReviewViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

// Represents set of checkins
@Observable class ReviewViewModel {
  private let relationship: Relationship
  private let review: Review

  var id: String {
    review.id
  }
  var date: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/DD/YYYY"
    return formatter.date(from: review.date)
  }
  var answers: [CheckInViewModel] {
    review.answers.compactMap { checkIn in
      CheckInViewModel(checkIn: checkIn)
    }
  }

  func getReview() {
    guard let data = UserDefaults.standard.object(forKey: "Submitted") as? Data,
    let review = try? JSONDecoder().decode(AnswersToSubmit.self, from: data) else {
      return
    }

  }

  init(relationship: Relationship, review: Review) {
    self.relationship = relationship
    self.review = review
  }
}

