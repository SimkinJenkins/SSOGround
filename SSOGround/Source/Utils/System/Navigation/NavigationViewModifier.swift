//
//  NavigationViewModifier.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 06/10/24.
//

import SwiftUI

struct NavigationViewModifier: ViewModifier {
    @Bindable var navigation: Navigation

    func body(content: Content) -> some View {
        content
            .navigationTitle(navigation.title)
            .navigationDestination(for: AppView.self) { view in
                buildView(view)
            }
            .sheet(item: $navigation.sheet) { sheet in
                buildView(sheet)
            }
    }

    @ViewBuilder
    private func buildView(_ view: AppView) -> some View {
        switch view {
        case .settings:
            SettingsView()
        case .editProfile(let user):
            EditProfileView(user: user)
        }
    }
}

extension View {
    func navigation(_ navigation: Navigation) -> some View {
        modifier(NavigationViewModifier(navigation: navigation))
    }
}
