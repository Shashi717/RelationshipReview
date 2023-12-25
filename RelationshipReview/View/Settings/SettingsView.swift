//
//  SettingsView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/25/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isLoggedIn: Bool
    var body: some View {
        VStack {
            EditUserInfoView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Sign out") {
                    signOut()
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
}

#Preview {
    SettingsView(isLoggedIn: .constant(false))
}
