//
//  MIVideoPlayerView.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI
import AVKit
import Combine

struct MIVideoPlayerView: View {
    let url: String
    @State private var isMuted = true
    @State private var cachedVideoURL: URL? = nil
    @State private var player: AVPlayer? = nil
    
    @StateObject private var playerManager = MIVideoPlayerManager.shared
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                if let cachedVideoURL = cachedVideoURL {
                    VideoPlayer(player: player)
                        .disabled(true)
                        .onAppear {
                            checkVisibility(proxy: proxy)
                        }
                        .onDisappear {
                            
                        }
                } else {
                    ProgressView()
                        .onAppear {
                            MIVideoCacheService.shared.cacheVideo(from: url) { cachedURL in
                                DispatchQueue.main.async {
                                    if let cachedURL = cachedURL {
                                        self.cachedVideoURL = cachedURL
                                        let newPlayer = AVPlayer(url: cachedURL)
                                        newPlayer.isMuted = isMuted
                                        self.player = newPlayer
                                        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: newPlayer.currentItem, queue: .main) { _ in
                                            newPlayer.seek(to: .zero)
                                            newPlayer.play()
                                        }
                                    }
                                }
                            }
                        }
                }
                
                Button(action: {
                    isMuted.toggle()
                    player?.isMuted = isMuted
                }) {
                    Image(systemName: isMuted ? MIConstants.Icons.speakerSlashFill : MIConstants.Icons.speakerFill)
                        .padding(MIConstants.smallPadding)
                        .background(MIConstants.Colors.blackOpacity)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .padding(MIConstants.smallPadding)
            }
            .onChange(of: proxy.frame(in: .global).midY) { _ in
                checkVisibility(proxy: proxy)
            }
        }
    }

    private func checkVisibility(proxy: GeometryProxy) {
        let frame = proxy.frame(in: .global)
        let screenHeight = UIScreen.main.bounds.height
        let isVisible = frame.midY > 0 && frame.midY < screenHeight

        if isVisible {
            player?.play()
        } else {
            player?.pause()
        }
    }
}
