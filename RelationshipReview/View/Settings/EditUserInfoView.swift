//
//  EditUserInfoView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import SwiftUI
import FirebaseAuth

struct EditUserInfoView: View {
    @State var userInfoViewModel = UserInfoViewModel()
    var body: some View {
        VStack {
            TextField("First Name", text: $userInfoViewModel.firstName, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            TextField("Last Name", text: $userInfoViewModel.lastName, axis: .vertical)
                .textFieldStyle(.roundedBorder)

            HStack {
                Text("Communication Level").frame(alignment: .leading)
                Picker("", selection: $userInfoViewModel.communicationLevel) {
                    ForEach(CommunicationLevel.allCases) { level in
                        Text(level.description)
                    }
                }
            }

            TextField("Partner email", text: $userInfoViewModel.partnerEmail, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            Button("Submit") {
                submit()
            }
        }.padding(EdgeInsets(top: 32, leading: 32, bottom: 16, trailing: 32))
            .onAppear {
                Task {
                    await userInfoViewModel.loadUserInfo()
                }
            }
    }

    private func submit() {
        Task {
            await userInfoViewModel.updateUserInfo()
        }
    }
}

#Preview {
    EditUserInfoView()
}
