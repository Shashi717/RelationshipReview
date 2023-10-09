//
//  ContentView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 10/9/23.
//

import SwiftUI

struct ContentView: View {
  @State var checkInViewModel: CheckInViewModel
    var body: some View {
        CheckInView(checkInViewModel: checkInViewModel)
        .padding()
    }
}

#Preview {
  ContentView(checkInViewModel: MockData().mockCheckInViewModel)
}

struct MockData {
  let mockPrompt = Prompt(id: "1", type: .general, description: "What's your rating?", communicationLevel: .beginner)
  let mockCheckInViewModel = CheckInViewModel(checkIn: CheckIn(id: "1", promptId: "1", answer: "Great", partnerAnswer: "Not Great", markedAsDiscussion: true))
}
