//
//  MeasureView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 10.08.22.
//

import SwiftUI

struct MeasureView: View {
    @ObservedObject var BluethoothModel = BLEModel()
    @ObservedObject var HRVModel = HRV()
    var body: some View {
        Text(String(BluethoothModel.bpm ?? 0))
            .font(.custom("Ubuntu-Regular", size: 100))
        
        Button {
            HRVModel.startMeasure()
        } label: {
            Text("Start")
        }
        
        Button {
            HRVModel.analyzeIntervals()
        } label: {
            Text("Stop")
            Text("\(HRVModel.hrv)")
        }
        
        Button {
            HRVModel.addData()
        } label: {
            Text("Speichern")
        }

        
    }
}



