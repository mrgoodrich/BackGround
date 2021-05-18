//
//  BackGroundApp.swift
//  Shared
//
//  Created by Matt Goodrich on 5/13/21.
//

import SwiftUI
import CoreData

@main
struct BackGroundApp: App {
    // For saving changes to CoreData when app moves to background. (1/2)
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        // For saving changes to CoreData when app moves to background. (2/2)
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
    
    init () {
        checkFirstLoad(viewContext: persistenceController.container.viewContext)
    }
}

/// Initializes favorite locations on the first run of the app.
///
/// - Parameter viewContext: The context to save the default locations (CloudKit CoreData).
func checkFirstLoad(viewContext: NSManagedObjectContext) {
    // Use local UserDefaults.
    // TODO: Change to CloudKit calls. (Not adding for this demo to thin code and show features).
    let defaults = UserDefaults.standard
    let hasOnboarded = defaults.bool(forKey: "hasOnboarded")

    if (!hasOnboarded) {
        CoreDataHelper.addLocation(viewContext: viewContext, ident: "kpwm")
        CoreDataHelper.addLocation(viewContext: viewContext, ident: "kaus")
        
        // Set hasOnboarded to prevent adding default favorites more than once.
        defaults.set("true", forKey: "hasOnboarded")
    }
}
