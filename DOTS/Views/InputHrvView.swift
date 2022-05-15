//
//  InputHrvView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 13.05.22.
//

import SwiftUI

struct InputHrvView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
  
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // TODO: change to :Float
    @State private var hrv = ""

    var model:ContentModel
    
    var SaveButton: some View {
        Button("Speichern") {
            
            addData()
            
            clear()
            
            model.fetchHearts()
            model.fetchHeartsFirst()
            
            self.presentationMode.wrappedValue.dismiss()
            
        }
        .disabled(hrv.isEmpty)
    }
    var body: some View {
        
        
            if model.lastTimestampHrv() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: -2, to: NSDate() as Date)!) {
                if Int((NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: model.lastTimestampHrv())!)).timeIntervalSinceNow / 3600 / 24).rounded(.up)) == 1 {
                    Text("Herzfrequenzvariabilität morgen eingeben")
                }
                else {
                    Text("Herzfrequenzvariabilität in \(Int((NSCalendar.current.startOfDay(for:(NSCalendar.current.date(byAdding: .day, value: 3, to: model.lastTimestampHrv())!)).timeIntervalSinceNow / 3600 / 24).rounded(.up))) Tagen eingeben")
                }
                
            }
            else {
                VStack {
                    //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                    HStack {
                        Text("Herzfrequenzvariabilität:")
                            .padding()
                        
                        TextField("...................", text: $hrv)
                            .keyboardType(.decimalPad)
                            .frame(width: 60)
                            
                            
                        
                        Text("ms")
                            .padding([.top, .trailing, .bottom])
                    }

                Spacer()
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

