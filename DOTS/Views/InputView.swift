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
        .font(.custom("Ubuntu-Medium", size: 18))
        .disabled(rhr.isEmpty)
    }
    var body: some View {
        if model.lastTimestampRhr() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) {
            
                Text("Ruheherzfrequenz morgen eingeben")
                .font(.custom("Ubuntu-Medium", size: 22))
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
                Text("Ruheherzfrequenz")
                    .font(.custom("Ubuntu-Medium", size: 24))
                    .lineLimit(2)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.5)
                    .padding()
                //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                HStack {
                    
                    // TODO: textxfield appear automatically
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
        hearts.timestamp = Date()
        hearts.rhr = Double(rhr) as NSNumber?

        
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
    
}
 
