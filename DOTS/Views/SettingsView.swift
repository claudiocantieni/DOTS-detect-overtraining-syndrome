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
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(color: .gray, radius:5)
                                .frame(height: 48)
                                .padding()
                            HStack(spacing: 20.0) {
                                Image(systemName: "bell")
                                Text("Mitteilungen anpassen")
                                    .font(.title2)
                                    .foregroundColor(.accentColor)
                                    .lineLimit(2)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.leading)
                                
                                    
                            }
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
