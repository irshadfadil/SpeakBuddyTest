//
//  BackgroundView.swift
//  SpeakBuddyTest
//
//  Created by Fadil on 30/03/25.
//

import SwiftUI

/// The background view with the light purple color and gradient to white at bottom
struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors:
                                [Color(red: 213/255, green: 210/255, blue: 255/255),
                                Color(red: 255/255, green: 255/255, blue: 255/255)
                                ]
                              ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
