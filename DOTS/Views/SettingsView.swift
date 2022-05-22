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
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Button {
                        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings)
                        }
                    }
                    label: {
                        
                                
                            HStack(spacing: 20.0) {
                                Image(systemName: "bell")

                                Text("Mitteilungen anpassen")
                                    .font(.title2)
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
                        WelcomeView(isButtonNeeded: false)
                    } label: {
                            HStack(spacing: 20.0) {
                                Image(systemName: "book.closed")
                                    
                                Text("Benutzungsanleitung")
                                    .font(.title2)
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
                }
                
            }
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
