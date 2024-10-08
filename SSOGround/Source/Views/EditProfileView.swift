//
//  EditProfileView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 06/10/24.
//

import SwiftUI

struct EditProfileView: View {
    @Bindable var user: User

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("Email", text: $user.email)
        }
    }
}

#Preview {
    EditProfileView(user: User(email: ""))
}
