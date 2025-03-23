//
//  MyInstaApp.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import SwiftUI

@main
struct MyInstaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: nil, cacheManager: MICacheManager.shared)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    if ProcessInfo.processInfo.arguments.contains("UITesting") {
                        let mockDataService = MIMockDataService()
                        let mockCacheManager = MIMockCacheManager()
                        if ProcessInfo.processInfo.arguments.contains("SimulateError") {
                            mockDataService.shouldFail = true
                        } else {
                            mockDataService.mockPosts = mockDataService.generateMockData()
                        }
                        let viewModel = MIPostsViewModel(dataService: mockDataService, cacheManager: mockCacheManager)
                        ContentView(viewModel: StateObject(wrappedValue: viewModel), cacheManager: mockCacheManager)
                    }
                }
        }
    }
}
