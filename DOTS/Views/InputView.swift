//
//  InputView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 01.05.22.
//

import SwiftUI

struct InputView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    // TODO: change to :Float
    @State private var rhrData = ""
    @State private var hrvData = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button("Clear") {
                    
                    clear()
                }
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
                        TextField("50", text: $rhrData)
                        
                    }
                    
                    HStack {
                        Text("Herzfrequenzvariabilität:")
                        TextField("101.18", text: $hrvData)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func clear() {
        rhrData = ""
        hrvData = ""
    }
    
    func addData() {
        //TODO: adapt to textfields
        let datasets = Datasets(context: viewContext)
        datasets.rhrData.append(Float(rhrData)!)
        datasets.hrvData.append(Float(hrvData)!)
        
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
