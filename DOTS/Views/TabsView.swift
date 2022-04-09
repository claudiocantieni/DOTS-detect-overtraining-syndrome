//
//  ContentView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI

struct TabsView: View {
    
    @EnvironmentObject var model: ContentModel
    var modules:Model
    var body: some View {
        TabView {
            
            HomeView(module:Model())
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    
                }
            
            AnalisisView()
                .tabItem {
                    VStack {
                        Image(systemName: "waveform.path.ecg.rectangle")
                        Text("Analisis")
                    }
                }
            
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(modules: Model())
    }
}
