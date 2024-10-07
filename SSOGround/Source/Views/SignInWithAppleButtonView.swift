//
//  SignInWithAppleButtonView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 25/09/24.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: UIViewRepresentable {
    var didCompleteWithAuthorization: ((ASAuthorizationAppleIDCredential) -> ())?

    init(didCompleteWithAuthorization: ((ASAuthorizationAppleIDCredential) -> Void)? = nil) {
        self.didCompleteWithAuthorization = didCompleteWithAuthorization
    }

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        let parent: SignInWithAppleButtonView

        init(_ parent: SignInWithAppleButtonView) {
            self.parent = parent
        }

        @objc func didTapButton() {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]

            let authController = ASAuthorizationController(authorizationRequests: [request])
            authController.delegate = self
            authController.presentationContextProvider = self
            authController.performRequests()
        }
    }
}

extension SignInWithAppleButtonView.Coordinator: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        parent.didCompleteWithAuthorization?(appleIDCredential)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Log.error("Authorization failed: \(error.localizedDescription) \n\n -> called from \(#function) \(#file):\(#line)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
}
