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
                    The shape displays the status “loaded” for several weeks.
                    
                    This suggests a possible overreaching. If there is no logical reason, such as illness or deliberate supercompensation, it should be clarified with the coach whether action should be taken. In this case, the training is usually reduced.

                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                .presentationDetents([.medium])
            } else {
                Text("""
                    The shape displays the status “loaded” for several weeks.
                    
                    This suggests a possible overreaching. If there is no logical reason, such as illness or deliberate supercompensation, it should be clarified with the coach whether action should be taken. In this case, the training is usually reduced.

                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
            }
            
        }
    }
}

