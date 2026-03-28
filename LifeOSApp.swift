//
//  LifeOSApp.swift
//  LifeOS
//
//  Created by Ajith Pepi Anbu Selvan on 16/03/26.
//

import SwiftUI
import SwiftData

@main
struct LifeOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(PersistenceController.shared.container)
    }
}
