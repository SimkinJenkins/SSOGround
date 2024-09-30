//
//  ContentView.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 24/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Sign in to continue")
                .font(.title)
                .padding()

            SignInWithAppleButtonView()
                .frame(width: 280, height: 45)
                .padding()
        }
    }
}
