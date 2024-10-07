//
//  Listable.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 29/09/24.
//

import Foundation

/// Protocol util to make any enum listable
protocol Listable: CaseIterable, Hashable, Identifiable {
    var id: Self { get }
    var name: String { get }
}

extension Listable {
    var id: Self {
        return self
    }
    var name: String {
        return "\(self)"
    }
}
