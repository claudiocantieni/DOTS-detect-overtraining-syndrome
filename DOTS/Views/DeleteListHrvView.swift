//
//  DeleteListHrvView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 24.09.22.
//

import SwiftUI

struct DeleteListHrvView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        List {
            ForEach(model.heartsAll) { item in
                if item.hrv != nil {
                    
                    HStack() {
                        Text("\(item.timestamp.formatted(date: .numeric, time: .omitted))")
                            .font(.custom("Ubuntu-Medium", size: 18))
                            .padding(.horizontal)
                        Spacer()
                        
                        Text("\(Int(item.hrv!))")
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


