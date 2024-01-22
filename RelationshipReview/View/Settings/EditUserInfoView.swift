//
//  EditUserInfoView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import SwiftUI
import FirebaseAuth

struct EditUserInfoView: View {
    @State var userInfoViewModel: UserInfoViewModel
//    @Binding var relationship
    var body: some View {
        VStack {
            TextField("First Name", text: $userInfoViewModel.firstName, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            TextField("Last Name", text: $userInfoViewModel.lastName, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            TextField("Partner email", text: $userInfoViewModel.partnerEmail, axis: .vertical)
                .textFieldStyle(.roundedBorder)

            HStack {
                Text("Communication Level").frame(alignment: .leading)
                Picker("", selection: $userInfoViewModel.communicationLevel) {
                    ForEach(CommunicationLevel.allCases) { level in
                        Text(level.description)
                    }
                }
            }

            Button("Submit") {
                submit()
            }
            .buttonStyle(.borderedProminent)
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 24, trailing: 0))
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 24))
        .background(.ultraThickMaterial)
        .clipShape(.rect(cornerSize: CGSize(width: 20, height: 20)))
    }

    private func submit() {
        Task {
            await userInfoViewModel.updateUserInfo()
        }
    }
}

#Preview {
    EditUserInfoView(userInfoViewModel: UserInfoViewModel(networkClient: NetworkClient()))
}
