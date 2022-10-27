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
                    A heart rate monitor with Bluetooth support has to be used for measurement.

                    The measurement should be taken in the morning lying down in a relaxed state.
                    If you feel the urge to urinate, you should relieve yourself of water before taking the measurement, as retention can affect the pulse.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
                .presentationDetents([.medium])
            } else {
                Text("""
                    A heart rate monitor with Bluetooth support has to be used for measurement.

                    The measurement should be taken in the morning lying down in a relaxed state.
                    If you feel the urge to urinate, you should relieve yourself of water before taking the measurement, as retention can affect the pulse.
                    """)
                .multilineTextAlignment(.leading)
                .font(.custom("Ubuntu-Regular", size: 16))
                .padding()
                .lineSpacing(5)
            }
            
        }
    }
}

