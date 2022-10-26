//
//  SettingsView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 21.05.22.
//

import SwiftUI

class Theme2 {
    static func navigationBarColors(background : UIColor?,
       titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}

struct SettingsView: View {
    @Binding var tabSelection: Int
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    NavigationLink {
                        NotificationsView()
                    } label: {
                            HStack(spacing: 20.0) {
                                Image(systemName: "bell")
                                    
                                Text("Bluetooth & notifications")
                                    .font(.custom("Ubuntu-Medium", size: 20))
                                    .foregroundColor(.accentColor)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                Image(systemName: "chevron.right")
                                    
                            }
                        
                    }
                    .padding()
                    
                    NavigationLink {
                        WelcomeView(tabSelection: $tabSelection)
                    } label: {
                            HStack(spacing: 20.0) {
                                Image(systemName: "book.closed")
                                    
                                Text("User manual")
                                    .font(.custom("Ubuntu-Medium", size: 20))
                                    .foregroundColor(.accentColor)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                Image(systemName: "chevron.right")
                                    
                            }
                        
                    }
                    .padding()
                    
                    Link(destination: URL(string: "https://www.iubenda.com/privacy-policy/36559478")!) {
                        HStack(spacing: 20.0) {
                            Image(systemName: "lock.shield")
                                
                            Text("Privacy policy")
                                .font(.custom("Ubuntu-Medium", size: 20))
                                .foregroundColor(.accentColor)
                                .lineLimit(1)
                                .allowsTightening(true)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                
                        }
                    }
                    .padding()
//                    NavigationLink {
//                       AnalyzeView()
//                    } label: {
//                            HStack(spacing: 20.0) {
//                                Image(systemName: "folder")
//
//                                Text("Datenauswertung")
//                                    .font(.title2)
//                                    .foregroundColor(.accentColor)
//                                    .lineLimit(1)
//                                    .allowsTightening(true)
//                                    .minimumScaleFactor(0.5)
//                                    .multilineTextAlignment(.leading)
//
//                                Spacer()
//                                Image(systemName: "chevron.right")
//
//                            }
//
//                    }
//                    .padding()
                }
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
