//
//  SSOGroundApp.swift
//  SSOGround
//
//  Created by Patricio Bravo Cisneros on 24/09/24.
//

import SwiftUI
import SwiftData

@main
struct SSOGroundApp: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SSOHomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
