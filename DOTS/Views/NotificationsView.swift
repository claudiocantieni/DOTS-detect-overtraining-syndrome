//
//  SettingsView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

//import SwiftUI
//import UserNotifications
//
//
//struct NotificationsView: View {
//
//    @EnvironmentObject var manager: NotificationManager
//
//    var body: some View {
//        VStack {
//            Button {
//                if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
//                    UIApplication.shared.open(appSettings)
//                }
//            } label: {
//                Text("Benachrichtigungen")
//            }
//
//            Toggle("Benachrichtigungen", isOn: Binding<Bool>(
//                get: { manager.notificationsOn! },
//                set: {_ in
//                    // $0 is the new Bool value of the toggle
//                    // Your code for updating the model, or whatever
//                    if manager.notificationsOn == true {
//                        manager.UnrequestAuthorization()
//                        manager.notificationsOn = false
//                    }
//                    else {
//                        manager.requestAuthorization()
//                        manager.notificationsOn = true
//                    }
//
//                        }
//                    )
//            )
//            Button("Request permission") {
//                NotificationManager.instance.requestAuthorization()
//            }
//            Button("Request permission") {
//                NotificationManager.instance.scheduleNotification()
//            }
        
        
//        }    //.onAppear(UIApplication.shared.applicationIconBadgeNumber = 0)
//    }
//}
