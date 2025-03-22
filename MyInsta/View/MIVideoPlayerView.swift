//
//  MIVideoPlayerView.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import AVKit
import SwiftUI

struct MIVideoPlayerView: View {
    let url: String
    @State private var isMuted = true
    @State private var cachedVideoURL: URL? = nil
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let cachedVideoURL = cachedVideoURL {
                VideoPlayer(player: AVPlayer(url: cachedVideoURL))
                    .onAppear {
                        AVPlayer(url: cachedVideoURL).play()
                    }
            } else {
                ProgressView()
                    .onAppear {
                        MIVideoCacheService.shared.cacheVideo(from: url) { cachedURL in
                            DispatchQueue.main.async {
                                self.cachedVideoURL = cachedURL
                            }
                        }
                    }
            }
            
            Button(action: {
                isMuted.toggle()
            }) {
                Image(systemName: isMuted ? MIConstants.Icons.speakerSlashFill : MIConstants.Icons.speakerFill)
                    .padding(MIConstants.smallPadding)
                    .background(MIConstants.Colors.blackOpacity)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
            .padding(MIConstants.smallPadding)
        }
    }
}
