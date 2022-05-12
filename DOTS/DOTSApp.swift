//
//  DOTSApp.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI

@main
struct DOTSApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environmentObject(ContentModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
