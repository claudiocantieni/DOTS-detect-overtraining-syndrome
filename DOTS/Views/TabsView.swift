//
//  ContentView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI

struct TabsView: View {
    
    // @EnvironmentObject var model: ContentModel
    var module:Model
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }

                }
           
            
            InputView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.and.pencil")
                        Text("Data")
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
        TabsView(module: Model())
    }
}
