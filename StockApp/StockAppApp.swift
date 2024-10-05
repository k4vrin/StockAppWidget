//
//  StockAppApp.swift
//  StockApp
//
//  Created by Mostafa Hosseini on 10/5/24.
//

import SwiftUI

@main
struct StockAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
