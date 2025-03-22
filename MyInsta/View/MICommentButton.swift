//
//  MICommentButton.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI

struct MICommentButton: View {
    let commentCount: Int
    
    var body: some View {
        HStack(spacing: MIConstants.smallPadding) {
            Image(systemName: MIConstants.Icons.bubbleRight)
                .foregroundColor(MIConstants.Colors.primary)
            Text(commentCount.formatCount())
                .font(MIConstants.Fonts.caption)
        }
    }
}
