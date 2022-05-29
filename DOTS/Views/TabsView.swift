//
//  ContentView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI

struct TabsView: View {
    
    @AppStorage("welcomeViewShown")
    var welcomeViewShown: Bool = false
    
    @State private var tabSelection = 1
    
    var body: some View {
        
        if welcomeViewShown {
            TabView(selection: $tabSelection) {
                
                HomeView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(1)
                    
               AddView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                    }
                    .tag(2)

                
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
                    .tag(3)
            }
            
        }
        // Ansicht beim ersten Launch der App, sonst normal^
        else {
            WelcomeView(isButtonNeeded: true)
        }
        
    }
}

