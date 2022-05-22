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
    
    var body: some View {
        
        if welcomeViewShown {
            TabView {
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    
               AddView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                    }

                
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
            }
        }
        else {
            WelcomeView(isButtonNeeded: true)
        }
        
    }
}

