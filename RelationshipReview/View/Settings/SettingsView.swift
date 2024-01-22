//
//  SettingsView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var userInfoViewModel: UserInfoViewModel
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationStack {
            VStack {
                EditUserInfoView(userInfoViewModel: userInfoViewModel)
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                Button {
                    updateRelationship()
                } label: {
                    Text("Update Relationship")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sign out") {
                        signOut()
                    }
                }
            }
        }
    }

    private func signOut() {
        do {
            try NetworkClient().signout()
            isLoggedIn = false
        } catch {
            print(error)
        }
    }

    private func updateRelationship() {
        Task {
            await userInfoViewModel.createRelationship()
        }
    }
}

#Preview {
    SettingsView(userInfoViewModel: .constant(UserInfoViewModel(networkClient: NetworkClient())), isLoggedIn: .constant(false))
}
