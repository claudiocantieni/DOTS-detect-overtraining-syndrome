//
//  DeleteListView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 24.09.22.
//

import SwiftUI

struct DeleteListRhrView: View {
    @EnvironmentObject var model:ContentModel
    
    
    var body: some View {
        // List of all rhr data
        List {
            ForEach(model.heartsAll) { item in
                if item.rhr != nil {
                    
                    HStack() {
                        Text("\(item.timestamp.formatted(date: .numeric, time: .omitted))")
                            .font(.custom("Ubuntu-Medium", size: 18))
                            .padding(.horizontal)
                        Spacer()
                        
                        Text("\(item.rhr!)")
                            .font(.custom("Ubuntu-Regular", size: 18))
                            .padding(.horizontal)
                    }
                }
            }
            .onDelete(perform: model.deleteHearts)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .navigationTitle("All data")
        
    }
}
/*
 import SwiftUI

 struct DeleteListRhrView: View {
     @EnvironmentObject var model:ContentModel
     
     var DoneButton: some View {
         Button {
             model.mocSave()
         } label: {
             Text("Fertig")
         }

     }
     
     var body: some View {
         List {
             ForEach(model.heartsAll) { item in
                 if item.rhr != nil {
                     
                     HStack() {
                         Text("\(item.timestamp.formatted(date: .numeric, time: .omitted))")
                             .font(.custom("Ubuntu-Medium", size: 18))
                             .padding(.horizontal)
                         Spacer()
                         
                         Text("\(item.rhr!)")
                             .font(.custom("Ubuntu-Regular", size: 18))
                             .padding(.horizontal)
                     }
                 }
             }
             .onDelete(perform: model.deleteHearts)
         }
         .toolbar {
             ToolbarItem(placement: .navigationBarLeading) {
                 EditButton()
             }
             ToolbarItem(placement: .navigationBarTrailing) {
                 DoneButton
             }
         }
         .navigationTitle("Alle Daten")
         
     }
 }

 */
