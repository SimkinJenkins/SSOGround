//
//  UserUtils.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 29/09/24.
//

import SwiftData
import SwiftUI
import AuthenticationServices

struct UserUtils {
    static func save(appleUser: ASAuthorizationAppleIDCredential, to modelContext: ModelContext, currentUsers: [User] = []) {
        Log.info("Existing user: \(String(describing: currentUsers.first?.id))")
        guard appleUser.identityToken != nil,
              let convertedUser = UserUtils.convert(appleUser: appleUser) else {
            return
        }
        if let user = currentUsers.first(where: { $0.id == convertedUser.id }) {
            Log.info("Login successful, updating user \(user.id)")
            user.ssoToken = convertedUser.ssoToken
            user.ssoTokenExpiration = convertedUser.ssoTokenExpiration
        } else {
            Log.info("Login successful, creating new user \(convertedUser.id)")
            modelContext.insert(convertedUser)
        }
        
    }

    static private func convert(appleUser: ASAuthorizationAppleIDCredential) -> User? {
        guard let identityToken = appleUser.identityToken else {
            return nil
        }
        let string = String(decoding: identityToken, as: UTF8.self)
        do {
            let json = try JWTDecoder.decode(jwtToken: string)
            guard let id = json["sub"] as? String,
                  let expiration = json["exp"] as? Int else {
                Log.error("Error decoding JWT: No sub or exp")
                return nil
            }
            return User(
                id: id,
                name: appleUser.fullName?.formatted() ?? "",
                email: appleUser.email ?? "",
                ssoToken: String(data: appleUser.authorizationCode ?? Data(), encoding: .utf8),
                ssoTokenExpiration: Date(timeIntervalSince1970: TimeInterval(expiration)),
                ssoType: .apple
            )
        } catch {
            Log.error("Error decoding JWT: \(error)")
            return nil
        }
    }
}

extension [User] {
    var currentUser: User? {
        let user = first(where: {
            // TODO: Add validation for expiredToken
            $0.ssoToken != nil
        })
        if let user {
            Log.info("currentUser: \(user.name)\nexpires: \(String(describing: user.ssoTokenExpiration?.formatted()))")
        }
        return user
    }
}
