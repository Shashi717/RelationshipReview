//
//  ReviewViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation

// Represents set of checkins
@Observable class ReviewViewModel {
  private let networkClient: NetworkClient
  private var relationship: Relationship
  private var review: Review?

  var id: String {
    review?.id ?? "0"
  }
  var date: Date? {
    guard let review = review else {
      return nil
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/DD/YYYY"
    return formatter.date(from: review.date)
  }
  var answers: [CheckInViewModel]? {
    guard let review = review else {
      return nil
    }
    return review.answers.compactMap { checkIn in
      CheckInViewModel(checkIn: checkIn)
    }
  }

  @MainActor
  func getReview(_ urlString: String) async {
    guard let review = await networkClient.fetchReview(urlString) else {
      return
    }
    self.review = review
  }

  func getReview() {
    guard let data = UserDefaults.standard.object(forKey: "Submitted") as? Data,
    let review = try? JSONDecoder().decode(AnswersToSubmit.self, from: data) else {
      return
    }
  }

  init(networkClient: NetworkClient, review: Review? = nil) {
    self.networkClient = networkClient
    // temp hard coded data
    self.relationship = Relationship(id: "1", partnerId: "2", communicationLevel: 0, relationshipStartDate: Date.now.description, excludedPromptTypes: [2])
    self.review = review
  }
}

