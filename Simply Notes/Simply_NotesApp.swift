//
//  Simply_NotesApp.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 03/07/25.
//

import SwiftUI
import SwiftData

@main
struct Simply_NotesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            VaultView()
        }
        .modelContainer(sharedModelContainer)
    }
}
