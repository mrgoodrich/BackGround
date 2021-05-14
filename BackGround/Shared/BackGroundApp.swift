//
//  BackGroundApp.swift
//  Shared
//
//  Created by Matt Goodrich on 5/13/21.
//

import SwiftUI

@main
struct BackGroundApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
