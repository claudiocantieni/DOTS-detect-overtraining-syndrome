//
//  AttentionPopoverView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 04.10.22.
//

import SwiftUI

struct AttentionPopoverView: View {
    @State private var showingPopover = false
    
    var body: some View {
        Button {
            showingPopover = true
        } label: {
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color.red)
                .font(.system(size: 27))
                
                
        
        }
        
        
        .sheet(isPresented: $showingPopover) {
            if #available(iOS 16.0, *) {
                Text("""
                    Der Zustand ist seit mehreren Wochen belastet
                    Das deutet auf eine mögliche Überbelastung hin,
                    deshalb sollte das mit dem Coach abgeklärt werden
                    ...
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                .presentationDetents([.medium])
            } else {
                Text("""
                    Der Zustand ist seit mehreren Wochen belastet
                    Das deutet auf eine mögliche Überbelastung hin,
                    deshalb sollte das mit dem Coach abgeklärt werden
                    ...
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
            }
            
        }
    }
}

