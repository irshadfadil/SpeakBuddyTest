//
//  VideoPlayerView.swift
//  SpeakBuddyTest
//
//  Created by Fadil on 30/03/25.
//

import SwiftUI
import AVKit

// MARK: - Video Player for MOV animation
/// A SwiftUI wrapper for AVPlayerViewController to play MOV files
struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false

        // Remove background
        playerController.view.backgroundColor = .clear

        // Start playback
        player.play()

        // Set up looping
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { _ in
                player.seek(to: CMTime.zero)
                player.play()
            }

        return playerController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}


#Preview {
    if let videoURL = Bundle.main.url(forResource: "graph_animation_demo", withExtension: "mov") {
        VideoPlayerView(videoURL: videoURL)
    }
}
