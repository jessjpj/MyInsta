//
//  MIVideoPlayerManager.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Combine
import SwiftUI
import AVKit

class MIVideoPlayerManager: ObservableObject {
    static let shared = MIVideoPlayerManager()
    
    @Published private(set) var currentPlayer: AVPlayer? = nil
    private var currentURL: URL? = nil
    
    private init() {}
    
    func setCurrentPlayer(_ player: AVPlayer?, for url: URL?) {
        if currentPlayer != player {
            currentPlayer?.pause()
            currentPlayer = player
            currentURL = url
        }
        if let currentPlayer = currentPlayer, let currentURL = currentURL, currentURL == url {
            currentPlayer.seek(to: .zero)
            currentPlayer.play()
        }
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: currentPlayer?.currentItem, queue: .main) { _ in
            self.currentPlayer?.seek(to: .zero)
            self.currentPlayer?.play()
        }
    }
    
    func pauseCurrentPlayer() {
        currentPlayer?.pause()
    }
}
