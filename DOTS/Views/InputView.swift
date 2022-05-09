//
//  InputView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 01.05.22.
//

import SwiftUI

struct InputView: View {
    
 @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var hearts: FetchedResults<Hearts>
    // TODO: change to :Float
    @State private var rhr1 = ""
    @State private var hrv1 = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                
                Button("Speichern") {
                    
                    addData()
                    
                    clear()
                }
            }
            HStack {
                
                VStack {
                    //TODO: textfields with value
                    HStack {
                        Text("Ruheherzfrequenz:")
                        TextField("50", text: $rhr1)
                        
                        
                    }
                    
                    HStack {
                        Text("Herzfrequenzvariabilität:")
                        TextField("101.18", text: $hrv1)
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

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
    
}

