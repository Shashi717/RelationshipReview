//
//  ReviewViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

// Represents set of checkins
class ReviewViewModel {
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

  init(relationship: Relationship, review: Review) {
    self.relationship = relationship
    self.review = review
  }
}

