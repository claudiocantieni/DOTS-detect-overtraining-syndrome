//
//  SettingsView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 21.05.22.
//

import SwiftUI

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
                            Text("Mitteilungen")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                                .lineLimit(2)
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
