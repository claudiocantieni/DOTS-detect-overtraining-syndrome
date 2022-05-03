//
//  ContentView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 03.04.22.
//

import SwiftUI

struct TabsView: View {
    let persistenceController = PersistenceController.shared
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
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
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
