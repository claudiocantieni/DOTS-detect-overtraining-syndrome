//
//  InputView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 01.05.22.
//

import SwiftUI

struct InputView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // TODO: change to :Float
    @State private var rhr = ""

    var model:ContentModel
    
    var SaveButton: some View {
        
        Button("Speichern") {
            
            addData()
            
            clear()
            
            model.fetchHearts()
            
            model.fetchHeartsFirst()
            
            self.presentationMode.wrappedValue.dismiss()
            
            
        }
        .disabled(rhr.isEmpty)
    }
    var body: some View {
        if model.lastTimestampRhr() >= NSCalendar.current.startOfDay(for:NSCalendar.current.date(byAdding: .day, value: 0, to: Date())!) {
            
                Text("Ruheherzfrequenz morgen eingeben")
        }
        else {
            VStack {
                
                //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                HStack {
                    Text("Ruheherzfrequenz:")
                        .padding()
                    
                    TextField("..........", text: $rhr)
                        .keyboardType(.decimalPad)
                        .frame(width: 30)
                        
                    Text("bpm")
                        .padding([.top, .trailing, .bottom])
                }

            Spacer()
            }
            
            .navigationBarItems(trailing:SaveButton)
            .padding()
        }
    }
    
    func clear() {
        rhr = ""
 
    }
    func addData() {
        //TODO: adapt to textfields
        
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

