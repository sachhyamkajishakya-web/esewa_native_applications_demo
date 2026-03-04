//
//  esewa_ios_appApp.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 03/03/2026.
//

import SwiftData
import SwiftUI

@main
struct esewa_ios_appApp: App {
    @AppStorage("userUUID") var uuid: String?
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
            if uuid != nil {
                LoginView()
            } else {
                //                start flutter view
                LoginView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
