//
//  ViewModel.swift
//  SpeakBuddyTest
//
//  Created by Fadil on 30/03/25.
//

import SwiftUI

class ViewModel: ObservableObject {
    // MARK: Properties
    @Published var animationProgress: CGFloat = 0

    // MARK: Animation Methods

    /// Starts the animation for the progress bars
    func startAnimation() {
        withAnimation(Animation.easeOut(duration: 1.5)) {
            self.animationProgress = 1.0
        }
    }

    /// Handles registration when user taps the button
    func registerPlan() {
        // Implementation for registration process
        print("Registration button tapped")
    }
}
