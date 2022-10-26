//
//  NotificationsVIew.swift
//  DOTS
//
//  Created by Claudio Cantieni on 25.10.22.
//

import SwiftUI


struct NotificationsView: View {
    @State var notHour = 0
    @State var notMinute = 0
    @AppStorage("notificationHour") var notificationHour: Int = 7
    @AppStorage("notificationMinute") var notificationMinute: Int = 0
    
    @EnvironmentObject var manager:NotificationManager
    var body: some View {
        ZStack {
            
            
            VStack(spacing: 20) {
                Button {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                        UIApplication.shared.open(appSettings)
                    }
                }
            label: {
                
                
                HStack(spacing: 20.0) {
                    Image(systemName: "bell")
                    
                    Text("Bluetooth & notifications")
                        .font(.custom("Ubuntu-Medium", size: 20))
                        .foregroundColor(.accentColor)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                    
                }
                
                
            }
            .padding()
                Text("Time of notification")
                    .font(.custom("Ubuntu-Medium", size: 20))
                GeometryReader { geometry in
                    
                    
                    HStack {
                        Spacer()
                        Picker("", selection: $notHour) {
                            ForEach(0..<25) { item in
                                Text(String(item))
                                    .scaleEffect(x: 2.5)
                            }
                            
                            
                        }
                        .pickerStyle(.wheel)
                        .scaleEffect(x: 0.4)
                        .frame(width: geometry.size.width / 3)
                        
                        
                        Picker("", selection: $notMinute) {
                            ForEach(0..<61) { item in
                                Text(String(item))
                                    .scaleEffect(x: 2.5)
                            }
                            
                        }
                        .pickerStyle(.wheel)
                        .scaleEffect(x: 0.4)
                        .frame(width: geometry.size.width / 3)
                        
                        Spacer()
                    }
                }
            }
            HStack(spacing: 20) {
                Button {
                    notHour = notificationHour
                    notMinute = notificationMinute
                    
                } label: {
                    ZStack {
                        if notHour == notificationHour && notMinute == notificationMinute {
                            Capsule()
                                .foregroundColor(.gray)
                                .frame(width: 150, height: 48)
                                .opacity(0.2)
                        }
                        else {
                            Capsule()
                                .foregroundColor(.gray)
                                .frame(width: 150, height: 48)
                                
                        }
                        
                        Text("Cancel")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                    
                }
                Button {
                    notificationHour = notHour
                    notificationMinute = notMinute
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    manager.scheduleNotificationRhr()
                    manager.scheduleNotificationHrv()
                    manager.scheduleNotificationQuestionnaire()
                    
                } label: {
                    ZStack {
                        if notHour == notificationHour && notMinute == notificationMinute {
                            Capsule()
                                .foregroundColor(.accentColor)
                                .frame(width: 150, height: 48)
                                .opacity(0.2)
                        }
                        else {
                            Capsule()
                                .foregroundColor(.accentColor)
                                .frame(width: 150, height: 48)
                                
                        }
                        
                        Text("Save")
                            .foregroundColor(.black)
                            .font(.custom("Ubuntu-Medium", size: 18))
                    }
                    
                }

            }
            .padding(.top, 130)
        }
        .onAppear {
            notHour = notificationHour
            notMinute = notificationMinute
        }
        
    }
}



