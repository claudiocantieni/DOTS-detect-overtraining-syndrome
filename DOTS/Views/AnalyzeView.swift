//
//  AnalyzeView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 18.06.22.
//

import SwiftUI

struct AnalyzeView: View {
    
    @EnvironmentObject var model:ContentModel
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Herzfrequenz")
                ForEach(model.hearts365) {f in
                    HStack() {
                        Text("\(f.timestamp.formatted(date: .numeric, time: .omitted))")
                        Text("\(f.rhr ?? 0 ) bpm")
                        Text("\(f.hrv ?? 0 ) ms")
                    }
                    .padding(.horizontal)
                
                }
                Text("Fragebogen")
                ForEach(model.questionsdata) {f in
                    HStack() {
                        Text("\(f.timestamp.formatted(date: .numeric, time: .omitted))")
                        ForEach(f.answers, id: \.self) {i in
                                Text("\(i)")
                            }
                    }
                    .padding(.horizontal)
                
                }
                Text("Belastungszustand")
                ForEach(model.loads365) {f in
                    HStack() {
                        Text("\(f.timestamp.formatted(date: .numeric, time: .omitted))")
                        Text("\(f.load)")
                    }
                    .padding(.horizontal)
                
                }
            }
            
        }
    }
}



