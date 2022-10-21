//
//  MeasureViewPopover.swift
//  DOTS
//
//  Created by Claudio Cantieni on 21.10.22.
//

import SwiftUI

struct MeasurePopoverView: View {
    @State private var showingPopover = false
    
    var body: some View {
        Button {
            showingPopover = true
        } label: {
            Image(systemName: "info.circle")
                .foregroundColor(Color(red: 0.14, green: 0.45, blue: 0.73))
                
                
        
        }
        
        
        .sheet(isPresented: $showingPopover) {
            if #available(iOS 16.0, *) {
                Text("""
                    Die Messung sollte am Morgen liegend in entspanntem Zustand durchgeführt werden.
                    
                    Bei Harndrang sollte vor dem Messsen Wasser gelassen werden, weil das Zurückhalten den Puls beeinflussen kann.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                .presentationDetents([.medium])
            } else {
                Text("""
                    Die Messung sollte am Morgen liegend in entspanntem Zustand durchgeführt werden.
                    
                    Bei Harndrang sollte vor dem Messsen Wasser gelassen werden, weil das Zurückhalten den Puls beeinflussen kann.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
            }
            
        }
    }
}

