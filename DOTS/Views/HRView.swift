//
//  HRView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 07.04.22.
//

import SwiftUI
import SwiftUICharts

struct HRView: View {
    
    var title = "Ruheherzfrequenz"
    @State var selectedTimeRange = 0
    var HRData: [Double] = [48, 50, 52, 51, 49, 50, 48]
    var body: some View {
        VStack {
            
            Text(title)
                .font(.title)
            
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
                        Text("48 bpm")
                            .bold()
                    }
                    .padding()
                    
                    HStack {
                        Text("Ø 7 Tage :")
                            .bold()
                        Text("49 bpm")
                            .bold()
                    }
                    .padding()
                    
                    HStack {
                        Text("∆ letze 7 Tage:")
                            .bold()
                        Text("+2 bpm")
                            .bold()
                    }
                    .padding()
                }
                .padding(.top, 200)
            }
        }
    }
}
struct HRView_Previews: PreviewProvider {
    static var previews: some View {
        HRView()
    }
}
