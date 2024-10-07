//
//  SSOSignInView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 24/09/24.
//

import SwiftUI
import AuthenticationServices

struct SSOSignInView: View {
    let users: [User]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                Text("Sign in to continue")
                    .font(.title)
            }
            .padding()
            SignInWithAppleButtonView() { authorization in
                UserUtils.save(appleUser: authorization, to: modelContext, currentUsers: users)
            }
                .frame(width: 280, height: 45)
                .padding()
        }
    }
}

#Preview {
    SSOSignInView(users: [])
}
