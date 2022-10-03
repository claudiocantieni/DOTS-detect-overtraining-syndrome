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
    @Published var RhrIdentifier = ["RhrIdentifier"]
    @Published var HrvIdentifier = ["HrvIdentifier"]
    @Published var QuestIdentifier = ["QuestIdentifier"]

    
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
    
    
    
    func scheduleNotificationQuestionnaire() {
        
        //        let center = UNUserNotificationCenter.current()
        
        //        let addRequest = {
        model.fetchQuestionnaire()
        
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Fill out questionnaire"
        content.sound = .default
        badgeNumber = 1
        content.badge = (badgeNumber) as NSNumber
        
        let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 7, to: self.model.timestampQuestionnaire())!))
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 7
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: QuestIdentifier.first!, content: content, trigger: trigger)
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
        model.fetchHearts()
        
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Record resting heart rate"
        content.sound = .default
        badgeNumber = 1
        content.badge = (badgeNumber) as NSNumber
        
        let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 1, to: self.model.lastTimestampRhr())!))
        //let date = model.lastTimestampRhr()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 7
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: RhrIdentifier.first!, content: content, trigger: trigger)
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
        model.fetchHearts()
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Record heart rate variability"
        content.sound = .default
        badgeNumber = 1
        content.badge = (badgeNumber) as NSNumber
        
        let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 1, to: self.model.lastTimestampHrv())!))
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 7
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: HrvIdentifier.first!, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    //        center.getNotificationSettings { settings in
    //            if settings.authorizationStatus == .authorized {
    //                addRequest()
    //            } else {
    //            }
    //        }
    //    }
    
    func testNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "DOTS"
        content.body = "Herzfrequenzvariabilität erfassen"
        content.sound = .default
        badgeNumber = 1
        content.badge = (badgeNumber) as NSNumber
        
        //let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 1, to: self.model.lastTimestampHrv())!))
        
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 52
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: HrvIdentifier.first!, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}

