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
                    Die Form zeigt seit mehreren Wochen den Status ”belastet” an.
                    
                    Das deutet auf eine mögliche Überbelastung hin. Falls kein logischer Grund vorliegt, wie Krankheit oder gewollte Superkompensation, sollte mit dem Coach abgeklärt werden, ob zu handeln ist. In diesem Fall wird meistens das Training reduziert.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                .presentationDetents([.medium])
            } else {
                Text("""
                    Die Form zeigt seit mehreren Wochen den Status ”belastet” an.
                    
                    Das deutet auf eine mögliche Überbelastung hin. Falls kein logischer Grund vorliegt, wie Krankheit oder gewollte Superkompensation, sollte mit dem Coach abgeklärt werden, ob zu handeln ist. In diesem Fall wird meistens das Training reduziert.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
            }
            
        }
    }
}

