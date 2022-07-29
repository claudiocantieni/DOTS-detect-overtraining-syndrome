//
//  ShapesView.swift
//  DOTS
//
//  Created by Claudio Cantieni on 29.07.22.
//

import SwiftUI

struct ButtonView: View {
    var color:Color
    var body: some View {
        Capsule()
            .foregroundColor(color)
            .frame(width: 200, height: 48)
            .padding()
    }
}


