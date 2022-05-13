//
//  AddView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 13.05.22.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var model:ContentModel
//    @State var isInputViewShowing = false
//    @State var isQuestionnaireViewShowing = false
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    NavigationLink {
                        InputView(model: model)
                    } label: {
                        HStack(spacing: 20.0) {
                            Image(systemName: "waveform.path.ecg")
                            Text("Ruheherzfrequenz eingeben")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                
                        }
                    }
                        .padding()
                    
                    NavigationLink {
                        InputHrvView(model: model)
                    } label: {
                        HStack(spacing: 20.0) {
                            Image(systemName: "waveform.path.ecg")
                            Text("Herzfrequenzvariabilität eingeben")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                
                        }
                    }
                        .padding()
                    NavigationLink {
                        QuestionnaireView()
                    } label: {
                        HStack(spacing: 20.0) {
                            Image(systemName: "square.and.pencil")
                            Text("Fragebogen ausfüllen")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Daten erfassen")
            
        }
        
        
    }
}
