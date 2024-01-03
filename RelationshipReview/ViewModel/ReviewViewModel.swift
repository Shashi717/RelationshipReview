//
//  ReviewViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import Foundation
import UIKit

// Represents set of checkins
@Observable class ReviewViewModel {
    private let networkClient: NetworkClient
    private var relationship: Relationship
    private var review: Review?
    
    var id: String {
        review?.id ?? "0"
    }
    var date: Date? {
        guard let review = review,
              let date = Double(review.date) else {
            return nil
        }
        return Date(timeIntervalSince1970: date)
    }
    var dateString: String {
        guard let date = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        return formatter.string(from: date)
    }
    var answers: [CheckInViewModel]? {
        guard let review = review else {
            return nil
        }
        return review.answers.compactMap { checkin in
            CheckInViewModel(checkIn: checkin)
        }
    }
    
    var profileImage: UIImage?
    var partnerProfileImage: UIImage?
    
    @MainActor
    func getReview(_ urlString: String) async {
        guard let review = await networkClient.fetchReview(urlString) else {
            return
        }
        self.review = review
        let urlString = "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
        let manURLString = "https://media.istockphoto.com/id/1364917563/photo/businessman-smiling-with-arms-crossed-on-white-background.jpg?s=612x612&w=0&k=20&c=NtM9Wbs1DBiGaiowsxJY6wNCnLf0POa65rYEwnZymrM="
        self.profileImage = await networkClient.fetchImage(urlString)
        self.partnerProfileImage = await networkClient.fetchImage(manURLString)
    }
    
    func getReview() {
        guard let data = UserDefaults.standard.object(forKey: "Submitted") as? Data,
              let review = try? JSONDecoder().decode(AnswersToSubmit.self, from: data) else {
            return
        }
    }
    
    func markAsDiscussion(_ id: String) async -> Bool {
        return await networkClient.markAsDiscussion("", id)
    }
    
    init(networkClient: NetworkClient, review: Review? = nil) {
        self.networkClient = networkClient
        // temp hard coded data
        self.relationship = Relationship(id: "1", partnerId: "2", communicationLevel: 0, relationshipStartDate: Date.now.description, excludedPromptTypes: [])
        self.review = review
    }
}
