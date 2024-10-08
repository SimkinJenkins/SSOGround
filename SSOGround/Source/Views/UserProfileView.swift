//
//  UserProfileView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 29/09/24.
//

import SwiftData
import SwiftUI

struct UserProfileView: View {
    @Environment(\.modelContext) private var modelContext
    var viewModel: UserProfileViewModel

    var body: some View {
        VStack {
            Text("Welcome, \(viewModel.user.name)")
                .font(.title)
                .padding()
            Text("Mail: \(viewModel.user.email)")
                .padding()
            Button("Logout") {
                viewModel.user.logout()
            }
            Button("Delete User") {
                viewModel.removeUser(modelContext: modelContext)
            }
        }
    }
}

#Preview {
    UserProfileView(viewModel: UserProfileViewModel(user: User(email: "simkin@example.com")))
}

final class UserProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }

    func removeUser(modelContext: ModelContext) {
        modelContext.delete(user)
    }
}
