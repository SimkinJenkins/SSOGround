//
//  Item.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 24/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
