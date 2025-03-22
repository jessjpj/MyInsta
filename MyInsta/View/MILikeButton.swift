//
//  MILikeButton.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI

struct MILikeButton: View {
    @Binding var isLiked: Bool
    let likeCount: Int
    
    var body: some View {
        Button(action: {
            isLiked.toggle()
        }) {
            HStack(spacing: MIConstants.smallPadding) {
                Image(systemName: isLiked ? MIConstants.Icons.heartFill : MIConstants.Icons.heart)
                    .foregroundColor(isLiked ? MIConstants.Colors.likeButton : MIConstants.Colors.primary)
                Text(likeCount.formatCount())
                    .font(MIConstants.Fonts.caption)
            }
        }
    }
}
