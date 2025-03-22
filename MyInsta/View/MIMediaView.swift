//
//  MIMediaView.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MIMediaView: View {
    let media: MIMedia
    @State private var thumbnail: UIImage? = nil
    private let thumbnailService: MIThumbnailService
    
    init(media: MIMedia, thumbnailService: MIThumbnailService = .shared) {
        self.media = media
        self.thumbnailService = thumbnailService
    }
    
    var body: some View {
        if media.type == MIConstants.Media.image {
            WebImage(url: URL(string: media.url)) { image in
                image.resizable()
            }
            placeholder: {
                Rectangle()
                    .fill(MIConstants.Colors.gray)
            }
            .scaledToFit()
        } else if media.type == MIConstants.Media.video {
            ZStack {
                if let thumbnail = thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    MIConstants.Colors.gray
                }
                
                MIVideoPlayerView(url: media.url)
            }
            .onAppear {
                thumbnailService.generateThumbnail(for: media.url) { thumbnail in
                    self.thumbnail = thumbnail
                }
            }
        }
    }
}
