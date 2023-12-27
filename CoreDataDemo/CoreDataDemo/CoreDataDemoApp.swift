//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by 김지훈 on 2023/12/27.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
