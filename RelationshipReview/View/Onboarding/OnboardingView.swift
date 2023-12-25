//
//  OnboardingView.swift
//  RelationshipReview
//
//  Created by Shashi Liyanage on 12/2/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var onboardingViewModel: OnboardingViewModel
    @Binding var isLoggedIn: Bool
    var body: some View {
        VStack {
            Text("Relationship Review")
                .font(.largeTitle)
                .fontDesign(.rounded)
            VStack {
                TextField("Email", text: $onboardingViewModel.email, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(top: 32, leading: 32, bottom: 16, trailing: 32))
                TextField("Password", text: $onboardingViewModel.password, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 32))
                Button("Signin")  {
                    signin()
                }
                .disabled(!onboardingViewModel.isValid)
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 32))
            }
        }
    }
    
    private func signin() {
        Task {
            do {
                let user = try await onboardingViewModel.login()
                isLoggedIn = (user != nil)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    OnboardingView(onboardingViewModel: OnboardingViewModel(), isLoggedIn: .constant(false))
}
