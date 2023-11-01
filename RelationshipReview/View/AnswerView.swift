//
//  AnswerView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 11/1/23.
//

import SwiftUI

struct AnswerView: View {
  let answer: String
  let profileImage: UIImage?
  var body: some View {
    HStack {
      if let image = profileImage {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .clipShape(.circle)
          .frame(width: 50, height: 50)
      }
      Text(answer)
    }
  }
}

#Preview {
  AnswerView(answer: "This is an answer", profileImage: nil)
}
