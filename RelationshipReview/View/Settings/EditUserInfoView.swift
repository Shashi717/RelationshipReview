//
//  EditUserInfoView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import SwiftUI
import FirebaseAuth

struct EditUserInfoView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var partnerEmail: String = ""
    @State var communicationLevel: CommunicationLevel = .beginner
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            TextField("Last Name", text: $lastName, axis: .vertical)
                .textFieldStyle(.roundedBorder)

            HStack {
                Text("Communication Level").frame(alignment: .leading)
                Picker("", selection: $communicationLevel) {
                    ForEach(CommunicationLevel.allCases) { level in
                        Text(level.description)
                    }
                }
            }

            TextField("Partner email", text: $partnerEmail, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            Button("Submit") {
                Task {
                    await submit()
                }
            }.padding(EdgeInsets(top: 32, leading: 32, bottom: 16, trailing: 32))
        }
    }
    private func submit() async {
        guard EmailHelper.isValidEmail(partnerEmail),
              !firstName.isEmpty,
              !lastName.isEmpty,
              let userId = NetworkClient().getCurrentUser()?.uid else {
            return
        }
        let userInfo: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "communication_level": communicationLevel.rawValue,
            "partner_email": partnerEmail
        ]
        // network request to add partner email
        do {
            try await NetworkClient().updateUserInfo(userId, userInfo)
        } catch {
            print(error)
        }

    }
}

#Preview {
    EditUserInfoView()
}
