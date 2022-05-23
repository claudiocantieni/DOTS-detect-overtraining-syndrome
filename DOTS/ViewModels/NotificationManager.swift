//
//  NotificationManager.swift
//  DOTS
//
//  Created by Claudio Cantieni on 21.05.22.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager: ObservableObject {
    init() {
        badgeNumber = UIApplication.shared.applicationIconBadgeNumber
  
    }
    var model = ContentModel()
    @Published var badgeNumber: Int
    
    //    @Published var notificationsOn: Bool?
    
    func requestAuthorization() {
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
    //    func UnrequestAuthorization() {
    //        let options: UNAuthorizationOptions = []
    //        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
    //            if let error = error {
    //                print("Error: \(error)")
    //            }
    //            else {
    //                print("No Notifications")
    //            }
    //        }
    //    }
    
    
    //    func areNotificationsOn() {
    //
    //        let center = UNUserNotificationCenter.current()
    //        center.getNotificationSettings { settings in
    //            guard (settings.authorizationStatus == .authorized)  else { return }
    //
    //            if settings.authorizationStatus == .authorized {
    //                self.notificationsOn = true
    //                // Schedule an alert-only notification.
    //            } else {
    //                self.notificationsOn = false
    //                // Schedule a notification with a badge and sound.
    //            }
    //        }
    //    }
    
    func scheduleNotificationQuestionnaire() {
        
        //        let center = UNUserNotificationCenter.current()
        
        //        let addRequest = {
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Fragebogen heute ausfüllen"
        content.sound = .default
        badgeNumber += 1
        content.badge = (badgeNumber) as NSNumber
        
        let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 7, to: self.model.timestampQuestionnaire())!))
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 7
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        //        center.getNotificationSettings { settings in
        //            if settings.authorizationStatus == .authorized {
        //                addRequest()
        //            } else {
        //            }
        //        }
        
        
    }
    func scheduleNotificationRhr() {
        //        let center = UNUserNotificationCenter.current()
        
        //        let addRequest = {
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Ruheherzfrequenz heute eingeben"
        content.sound = .default
        badgeNumber += 1
        content.badge = (badgeNumber) as NSNumber
        
        let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 7, to: self.model.lastTimestampRhr())!))
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 7
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        //        }
        //        center.getNotificationSettings { settings in
        //            if settings.authorizationStatus == .authorized {
        //                addRequest()
        //            } else {
        //            }
        //        }
    }
    func scheduleNotificationHrv() {
        //        let center = UNUserNotificationCenter.current()
        
        //        let addRequest = {
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Herzfrequenzvariabilität heute eingeben"
        content.sound = .default
        badgeNumber += 1
        content.badge = (badgeNumber) as NSNumber
        
        let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: self.model.lastTimestampHrv())!))
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 7
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    //        center.getNotificationSettings { settings in
    //            if settings.authorizationStatus == .authorized {
    //                addRequest()
    //            } else {
    //            }
    //        }
    //    }
}