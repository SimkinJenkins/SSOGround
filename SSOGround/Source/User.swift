//
//  User.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 29/09/24.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: String
    var name: String
    var email: String
    var ssoToken: String?
    var ssoTokenExpiration: Date?
    var ssoType: SSOType

    init(
        id: String = UUID().uuidString,
        name: String = "",
        email: String,
        ssoToken: String? = nil,
        ssoTokenExpiration: Date? = nil,
        ssoType: SSOType = .apple
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.ssoToken = ssoToken
        self.ssoTokenExpiration = ssoTokenExpiration
        self.ssoType = ssoType
    }

    func logout() {
        Log.info("Logging out user \(id), \(name)")
        ssoToken = nil
        ssoTokenExpiration = nil
    }
}
