//
//  Navigation.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 06/10/24.
//

import Foundation

@Observable
final class Navigation: ObservableObject {
    var title: String
    var path: [AppView] = []
    var sheet: AppView?

    func push(_ view: AppView) {
        path.append(view)
    }

    func present(_ view: AppView) {
        sheet = view
    }

    init(title: String = "") {
        self.title = title
    }
}
