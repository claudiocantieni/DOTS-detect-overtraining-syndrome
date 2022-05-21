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
    init() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")

            }
            else {
                print("Success")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environmentObject(ContentModel())
                .environmentObject(NotificationManager())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
