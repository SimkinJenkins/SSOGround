//
//  SSOSignInView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 24/09/24.
//

import SwiftUI
import AuthenticationServices

struct SSOSignInView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var navigation: Navigation

    let users: [User]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                Text("Sign in to continue")
                    .font(.title)
            }
            .padding()
            SignInWithAppleButtonView() { credentials in
                onAppleDidCompleteWithAuthorization(credentials)
                
            }
                .frame(width: 280, height: 45)
                .padding()
        }
    }

    private func onAppleDidCompleteWithAuthorization(_ credentials: ASAuthorizationAppleIDCredential) {
        UserUtils.save(appleUser: credentials, to: modelContext, currentUsers: users)
        guard let user = users.currentUser,
              user.name.isEmpty || user.email.isEmpty else {
            return
        }
        navigation.present(.editProfile(user))
    }
}

#Preview {
    SSOSignInView(users: [])
}
