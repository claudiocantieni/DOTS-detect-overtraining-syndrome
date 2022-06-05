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
        Button("Speichern") {
            
            let date = NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 1, to: self.model.lastTimestampHrv())!))
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
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: manager.HrvIdentifier)
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: manager.HrvIdentifier)
            
            manager.scheduleNotificationHrv()
            
            self.presentationMode.wrappedValue.dismiss()
            
        }
        .disabled(hrv.isEmpty)
    }
    var body: some View {
        if model.lastTimestampHrv() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) {
            
                Text("Herzfrequenzvariabilität morgen eingeben")
        }
            
        else {
                VStack {
                    //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                    HStack {
                        Text("Herzfrequenzvariabilität (RMSSD):")
                            .lineLimit(2)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                            .padding()
                        
                        TextField("xxx", text: $hrv)
                            .keyboardType(.decimalPad)
                            .frame(width: 50)
                            .lineLimit(1)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                            .focused($focusedField, equals: .field)
                                                    
                            
                        
                        Text("ms")
                            .padding([.top, .trailing, .bottom])
                    }

                Spacer()
                }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            focusedField = .field
                        }
                    }
                    .padding()
                    .navigationBarItems(trailing: SaveButton)
                
            }
            
    }
    
    func clear() {
        hrv = ""
    }
    func addData() {
        //TODO: adapt to textfields
        
        let hearts = Hearts(context: viewContext)
        hearts.timestamp = Date()
  
        hearts.hrv = Double(hrv) as NSNumber?
        
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
}

