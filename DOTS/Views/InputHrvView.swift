//
//  InputHrvView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 13.05.22.
//

import SwiftUI

struct InputHrvView: View {
    enum FocusField: Hashable {
            case field
          }
    @FocusState private var focusedField: FocusField?
        
    @Environment(\.managedObjectContext) private var viewContext
  
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // TODO: change to :Float
    @State private var hrv = ""

    var model:ContentModel
    @EnvironmentObject var manager:NotificationManager
    
    var SaveButton: some View {
        Button("Save") {
            var dateComponents = DateComponents()
            
            dateComponents.calendar = Calendar.current
            dateComponents.hour = 7
            dateComponents.minute = 0
            
            
            let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: self.model.timestampQuestionnaire())!))
            //let date = model.lastTimestampRhr()
            var dateComponents2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
            dateComponents2.calendar = Calendar.current
            dateComponents2.hour = 7
            dateComponents2.minute = 0
            
            if dateComponents.date! < Date() && dateComponents2.date! > Date() {
                manager.badgeNumber = 0
                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
            }
            
            addData()
            
            clear()
            
            model.fetchHearts()
            model.fetchHeartsFirst()
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: manager.HrvIdentifier)
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.HrvIdentifier)
            
            manager.scheduleNotificationHrv()
            
            self.presentationMode.wrappedValue.dismiss()
            
        }
        .font(.custom("Ubuntu-Medium", size: 18))
        .disabled(hrv.isEmpty)
    }
    var body: some View {
        if model.lastTimestampHrv() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) {
            
                Text("Enter heart rate variability tomorrow")
                .font(.custom("Ubuntu-Medium", size: 22))
                
        }
            
        else {
                VStack {
                    Text("Heart rate variability (RMSSD):")
                        .font(.custom("Ubuntu-Medium", size: 24))
                        .lineLimit(2)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .padding()
                    //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                    HStack {
                        
                        
                        TextField("", text: $hrv)
                            .keyboardType(.decimalPad)
                            .frame(width: 60)
                            .font(.custom("Ubuntu-Regular", size: 22))
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                            .focused($focusedField, equals: .field)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    
                            
                        
                        Text("ms")
                            .padding([.top, .trailing, .bottom])
                            .font(.custom("Ubuntu-Regular", size: 22))
                    }

                Spacer()
                }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            focusedField = .field
                        }
                    }
                    
                    .navigationBarItems(trailing:SaveButton)
                    .padding()
                }
            }
    
    func clear() {
        hrv = ""
    }
    func addData() {
        //TODO: adapt to textfields
        
        let hearts = Hearts(context: viewContext)
        hearts.timestamp = NSCalendar.current.date(byAdding: .second, value: 1, to: NSCalendar.current.startOfDay(for: Date()))!
  
        hearts.hrv = Double(hrv) as NSNumber?
        
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
}

