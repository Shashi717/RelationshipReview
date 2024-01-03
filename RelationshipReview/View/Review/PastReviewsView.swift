//
//  PastReviewsView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import SwiftUI

struct PastReviewsView: View {
    @State var pastReviewsViewModel: PastReviewsViewModel = PastReviewsViewModel()
    var body: some View {
        List {
            ForEach($pastReviewsViewModel.reviews, id: \.id) { $review in
                Text(review.dateString)
            }
        }
        .onAppear {
            // load past reviews
            Task {
                await pastReviewsViewModel.loadPastReviews()
            }
        }
    }
}

#Preview {
    PastReviewsView()
}
