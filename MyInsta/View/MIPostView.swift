//
//  MIPostView.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MIPostView: View {
    @StateObject var viewModel: MIPostViewModel
    
    init(post: MIPost) {
        _viewModel = StateObject(wrappedValue: MIPostViewModel(post: post))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: MIConstants.smallPadding) {
            HStack {
                MIProfilePicture(imageURL: viewModel.post.user.avatarThumb)
                Text(viewModel.post.user.name)
                    .font(MIConstants.Fonts.title)
                Spacer()
            }
            .padding(.horizontal, MIConstants.padding)

            MIMediaPaginator(media: viewModel.post.media)
                .frame(height: MIMediaUtility.calculateMediaHeight(viewModel.post.media.first?.resolution ?? MIConstants.Media.defaultResolution))

            HStack(spacing: MIConstants.padding) {
                MILikeButton(isLiked: $viewModel.isLiked, likeCount: viewModel.post.likes)
                    .onTapGesture {
                        viewModel.toggleLike()
                    }
                MICommentButton(commentCount: viewModel.post.comments.count)
                Spacer()
            }
            .padding(.horizontal, MIConstants.padding)

            Text(viewModel.post.caption)
                .font(MIConstants.Fonts.body)
                .lineLimit(viewModel.isDescriptionExpanded ? nil : MIConstants.descriptionLineLimit)
                .padding(.horizontal, MIConstants.padding)
            
            if !viewModel.isDescriptionExpanded && viewModel.post.caption.count > MIConstants.descriptionCharacterLimit {
                Button(MIConstants.moreText) {
                    viewModel.toggleDescriptionExpansion()
                }
                .font(MIConstants.Fonts.caption)
                .foregroundColor(MIConstants.Colors.primary)
                .padding(.horizontal, MIConstants.padding)
            }
        }
        .padding(.vertical, MIConstants.padding)
        .background(MIConstants.Colors.background)
    }
}
