//
//  MyInstaApp.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import SwiftUI

@main
struct MyInstaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
