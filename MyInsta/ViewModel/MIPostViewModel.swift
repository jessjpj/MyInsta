//
//  MIPostViewModel.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI
import Combine

class MIPostViewModel: ObservableObject {
    @Published var post: MIPost
    @Published var thumbnail: UIImage? = nil
    @Published var isDescriptionExpanded = false
    @Published var isLiked = false
    
    init(post: MIPost) {
        self.post = post
        generateThumbnail()
    }
    
    private func generateThumbnail() {
        if let media = post.media.first, media.type == MIConstants.Media.video {
            MIThumbnailService.shared.generateThumbnail(for: media.url) { thumbnail in
                DispatchQueue.main.async {
                    self.thumbnail = thumbnail
                }
            }
        }
    }
    
    func toggleLike() {
        isLiked.toggle()
        post.likes += isLiked ? 1 : -1
    }
    
    func toggleDescriptionExpansion() {
        isDescriptionExpanded.toggle()
    }
}
