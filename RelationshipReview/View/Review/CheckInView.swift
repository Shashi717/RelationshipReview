//
//  CheckInView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

struct CheckInView: View {
    let checkInViewModel: CheckInViewModel
    let profileImage: UIImage?
    let partnerProfileImage: UIImage?
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if checkInViewModel.markedAsDiscussion {
                    Image(systemName: "flag.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .tint(.green)
                }
                Text(checkInViewModel.question)
            }
            AnswerView(answer: checkInViewModel.answer, profileImage: profileImage)
                .frame(alignment: .leading)
            AnswerView(answer: checkInViewModel.partnerAnswer, profileImage: partnerProfileImage)
                .frame(alignment: .leading)
        }
    }
}

#Preview {
    CheckInView(checkInViewModel: MockData().mockCheckInViewModel, profileImage: nil, partnerProfileImage: nil)
}
