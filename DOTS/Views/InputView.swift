//
//  InputView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 01.05.22.
//

import SwiftUI

struct InputView: View {
    // keyboard pops up directly
    enum FocusField: Hashable {
            case field
          }
        @FocusState private var focusedField: FocusField?
        
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // TODO: change to :Float
    @State private var rhr = ""

    var model:ContentModel
    @EnvironmentObject var manager:NotificationManager
    
    var SaveButton: some View {
        // Button for toolbar
        Button("Save") {
            // check when last notification was sent, delete or leave it
            var dateComponents = DateComponents()
            
            dateComponents.calendar = Calendar.current
            dateComponents.hour = UserDefaults.standard.integer(forKey: "notificationHour")
            dateComponents.minute = UserDefaults.standard.integer(forKey: "notificationMinute")
            
            let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: self.model.timestampQuestionnaire())!))
            //let date = model.lastTimestampRhr()
            var dateComponents2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
            dateComponents2.calendar = Calendar.current
            dateComponents2.hour = UserDefaults.standard.integer(forKey: "notificationHour")
            dateComponents2.minute = UserDefaults.standard.integer(forKey: "notificationMinute")
            
            if dateComponents.date! < Date() && dateComponents2.date! > Date() {
                manager.badgeNumber = 0
                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
            }
            
            addData()
            
            clear()
            
            model.fetchHearts()
            
            model.fetchHeartsFirst()
            


            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.RhrIdentifier)
                
            
            // update load
            if  NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputRhr() as Date && NSCalendar.current.date(byAdding: .day, value: -7, to: NSDate() as Date)! > model.firstInputHrv() as Date { model.createLoad()}
            
            self.presentationMode.wrappedValue.dismiss()
            
            
        }
        .font(.custom("Ubuntu-Medium", size: 18))
        .disabled(rhr.isEmpty)
    }
    var body: some View {
        if model.lastTimestampRhr() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) {
            
                Text("Enter resting heart rate tomorrow")
                .font(.custom("Ubuntu-Medium", size: 22))
//                            Button {
//
//                                manager.badgeNumber = 0
//                                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
//            } label: {
//                Text("REmove")
//           }

        }
        
            
        else {
            VStack {
                Text("Resting heart rate:")
                    .font(.custom("Ubuntu-Medium", size: 24))
                    .lineLimit(2)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.5)
                    .padding()
                
                HStack {
                    
                    
                    TextField("", text: $rhr)
                        .keyboardType(.decimalPad)
                        .frame(width: 50)
                        .font(.custom("Ubuntu-Regular", size: 22))
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .focused($focusedField, equals: .field)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                
                        
                    Text("bpm")
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
            .padding()
            .navigationBarItems(trailing:SaveButton)
            
            
        }
        
    }
    
    func clear() {
        rhr = ""
 
    }
    func addData() {
        
        let hearts = Hearts(context: viewContext)
        hearts.timestamp = NSCalendar.current.startOfDay(for: Date())
        hearts.rhr = Double(rhr) as NSNumber?

        
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
    
}
 
