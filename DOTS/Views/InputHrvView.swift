//
//  InputHrvView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 13.05.22.
//

import SwiftUI

struct InputHrvView: View {
    @Environment(\.managedObjectContext) private var viewContext
  //  @FetchRequest(sortDescriptors: []) var hearts: FetchedResults<Hearts>
    // TODO: change to :Float
    @State private var hrv1 = ""
    //@Binding var isInputViewShowing: Bool
    var model:ContentModel
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                
                Button("Speichern") {
                    
                    addData()
                    
                    clear()
                    
                    model.fetchHearts()
                    
                    
                    
                }
            }
                    //TODO: textfields possible to copy paste letters -> prevent:https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
      
            HStack {
                Text("Herzfrequenzvariabilität:")
                TextField("101.18", text: $hrv1)
                    .keyboardType(.decimalPad)
            }
                    
                
            
        Spacer()
        }
        .padding(15)
    }
    
    func clear() {
        hrv1 = ""
    }
    func addData() {
        //TODO: adapt to textfields
        
        let hearts = Hearts(context: viewContext)
        hearts.timestamp = Date()
  
        hearts.hrv = Double(hrv1) as NSNumber?
        
        
       
       
        
        do {
            try viewContext.save()
            
        }
        catch {
            
        }
        
    }
}

