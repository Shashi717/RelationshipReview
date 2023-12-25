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
                    Button("Previous", systemImage: "arrowshape.backward.circle") {
                        currentIndex -= 1
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    .disabled(currentIndex == 0)
                    
                    Button("Next", systemImage: "arrowshape.forward.circle") {
                        currentIndex += 1
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    .disabled(currentIndex == answers.count - 1)
                    
                    Button("Discuss") {
                        submit()
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    private func submit() {
        guard let id = reviewViewModel.answers?[currentIndex].id else {
            return
        }
        Task {
            await reviewViewModel.markAsDiscussion(id)
        }
    }
}

#Preview {
    ReviewView(reviewViewModel: MockData().mockReviewViewModel)
}
