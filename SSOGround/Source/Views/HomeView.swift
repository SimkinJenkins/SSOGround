//
//  SSOHomeView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 29/09/24.
//

import SwiftData
import SwiftUI

struct SSOHomeView: View {
    @Query var users: [User]

    var body: some View {
        ZStack {
            if let user = users.currentUser {
                UserProfileView(viewModel: UserProfileViewModel(user: user))
            } else {
                SSOSignInView(users: users)
            }
        }
    }
}

#Preview {
    SSOHomeView()
}
