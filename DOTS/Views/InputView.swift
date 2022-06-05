//
//  InputView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 01.05.22.
//

import SwiftUI

struct InputView: View {
    
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
        
        Button("Speichern") {
            
            let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 1, to: self.model.lastTimestampRhr())!))
            //let date = model.lastTimestampRhr()
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            dateComponents.calendar = Calendar.current
            dateComponents.hour = 7
            dateComponents.minute = 0
            

            if dateComponents.date! < Date() {
                manager.badgeNumber -= 1
                UIApplication.shared.applicationIconBadgeNumber = manager.badgeNumber
            }
            
            addData()
            
            clear()
            
            model.fetchHearts()
            
            model.fetchHeartsFirst()
            

            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: manager.RhrIdentifier)
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.RhrIdentifier)
                
            manager.scheduleNotificationRhr()
            
            
            self.presentationMode.wrappedValue.dismiss()
            
            
        }
        .disabled(rhr.isEmpty)
    }
    var body: some View {
        if model.lastTimestampRhr() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) {
            
                Text("Ruheherzfrequenz morgen eingeben")
//            Button {
//                //manager.scheduleNotificationRhr()
//                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//            } label: {
//                Text("REmove")
//            }

        }
            
        else {
            VStack {
                
                //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                HStack {
                    Text("Ruheherzfrequenz:")
                        .lineLimit(2)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .padding()
                    // TODO: textxfield appear automatically
                    TextField("xx", text: $rhr)
                        .keyboardType(.decimalPad)
                        .frame(width: 50)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .focused($focusedField, equals: .field)
                
                        
                    Text("bpm")
                        .padding([.top, .trailing, .bottom])
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
        rhr = ""
 
    }
    func addData() {
        
        let hearts = Hearts(context: viewContext)
        hearts.timestamp = Date()
        hearts.rhr = Double(rhr) as NSNumber?

        
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
    
}
 
