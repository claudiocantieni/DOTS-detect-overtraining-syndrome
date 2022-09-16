//
//  MeasureView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 10.08.22.
//

import SwiftUI

struct MeasureView: View {
   // @ObservedObject var BluethoothModel = BLEModel()
    @ObservedObject var HRVModel = HRV()
    var colorScheme: Color
    @State private var index = 1
    var body: some View {
        //Text(String(BluethoothModel.bpm ?? 0))
         //   .font(.custom("Ubuntu-Regular", size: 100))
        if index == 1 {
            Button {
                HRVModel.startStopMeasure()
                index = 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                    HRVModel.startStopMeasure()
                    index = 3
                }
            } label: {
                ZStack {
                    ButtonView(color: .accentColor)
                    Text("Start")
                        .foregroundColor(colorScheme)
                        .font(.custom("Ubuntu-Medium", size: 18))
                }
            }
        }
        
        if index == 2 {
            Text("Messung läuft...")
                .foregroundColor(colorScheme)
                .font(.custom("Ubuntu-Medium", size: 18))
            
        }
        if index == 3 {
            VStack {
                Text("Ruheherzfrequenz: \(Int(HRVModel.hr))")
                    .foregroundColor(colorScheme)
                    .font(.custom("Ubuntu-Regular", size: 18))
                    .padding()
                
                Text("Herzfrequenzvariabilität: \(Int(HRVModel.hrv))")
                    .foregroundColor(colorScheme)
                    .font(.custom("Ubuntu-Regular", size: 18))
                    .padding()
                
            }
            
            Button {
                HRVModel.addData()
            } label: {
                ZStack {
                    ButtonView(color: .accentColor)
                    Text("Speichern")
                        .foregroundColor(colorScheme)
                        .font(.custom("Ubuntu-Medium", size: 18))
                }
            }
            .padding()
        }
        
        
        
    }
}



