//
//  PastReviewsViewModel.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 1/1/24.
//

import Foundation

@Observable class PastReviewsViewModel {
    var reviews: [ReviewViewModel] = []
    
    func loadPastReviews() async {
        let networkClient = NetworkClient()
        guard let userId = networkClient.getCurrentUser()?.uid else {
            return
        }
        do {
            let pastReviews = try await networkClient.fetchPastReviews(userId)
            reviews = pastReviews.map { review in
                ReviewViewModel(networkClient: networkClient, review: review)
            }
        } catch {
            print(error)
        }
        
    }
    
}
