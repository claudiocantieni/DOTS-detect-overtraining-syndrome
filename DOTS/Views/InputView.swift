//
//  InputView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 01.05.22.
//

import SwiftUI

struct InputView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
  //  @FetchRequest(sortDescriptors: []) var hearts: FetchedResults<Hearts>
    // TODO: change to :Float
    @State private var rhr1 = ""
    @State private var hrv1 = ""
    @Binding var isInputViewShowing: Bool
    var model:ContentModel
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                
                Button("Speichern") {
                    
                    addData()
                    
                    clear()
                    
                    model.fetchHearts()
                    
                    isInputViewShowing = false
                    
                    
                }
            }
            HStack {
                
                VStack {
                    //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                    HStack {
                        Text("Ruheherzfrequenz:")
                        TextField("50", text: $rhr1)
                            .keyboardType(.decimalPad)
                        
                        
                    }
                    
                    HStack {
                        Text("Herzfrequenzvariabilität:")
                        TextField("101.18", text: $hrv1)
                            .keyboardType(.decimalPad)
                    }
                    
                }
            }
        Spacer()
        }
        .padding(15)
    }
    
    func clear() {
        rhr1 = ""
        hrv1 = ""
    }
    func addData() {
        //TODO: adapt to textfields
        
        let hearts = Hearts(context: viewContext)
        hearts.timestamp = Date()
        hearts.rhr = Double(rhr1) as NSNumber?
        hearts.hrv = Double(hrv1) as NSNumber?
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
}

