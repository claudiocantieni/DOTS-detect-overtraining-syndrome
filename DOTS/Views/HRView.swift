//
//  HRView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 07.04.22.
//

import SwiftUI
import SwiftUICharts

struct HRView: View {
    
    var title: String
    @State var selectedTimeRange = 0
    var HRData: [Double]
    var today: String
    var av7days: String
    var delta7days: String
    var body: some View {
        VStack {
            
            Text(title)
                .font(.largeTitle)
                .bold()
            
            Picker("", selection: $selectedTimeRange)
            {
                Text("7 Tage").tag(0)
                Text("4 Wochen").tag(1)
                Text("1 Jahr").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 40)
            .padding()
            
            ZStack {
                LineView(data: HRData)
                    .padding(.horizontal)
                
                VStack {
                    HStack {
                        Text("Heute :")
                            .bold()
                        Text(today)
                            .bold()
                    }
                    .padding()
                    
                    HStack {
                        Text("Ø 7 Tage :")
                            .bold()
                        Text(av7days)
                            .bold()
                    }
                    .padding()
                    
                    HStack {
                        Text("∆ letze 7 Tage:")
                            .bold()
                        Text(delta7days)
                            .bold()
                    }
                    .padding()
                }
                .padding(.top, 200)
            }
        }
    }
}
