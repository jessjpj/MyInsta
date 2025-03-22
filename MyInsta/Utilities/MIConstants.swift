//
//  MIConstants.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import SwiftUI

struct MIConstants {
    static let padding: CGFloat = 16
    static let smallPadding: CGFloat = 8
    static let cornerRadius: CGFloat = 12
    static let shadowRadius: CGFloat = 5
    static let mediaAspectRatio: CGFloat = 300
    static let descriptionLineLimit: Int = 2
    static let descriptionCharacterLimit: Int = 100
    static let moreText = "...more"
    static let appName = "MyInsta"
    static let loadingText = "Loading posts..."
    static let errorTitle = "Error"
    static let okButtonText = "OK"
    static let unknownError = "An unknown error occurred."
    
    struct Colors {
        static let primary = Color.primary
        static let secondary = Color.secondary
        static let background = Color(.systemBackground)
        static let likeButton = Color.red
        static let commentButton = Color.blue
        static let gray = Color.gray
        static let blackOpacity = Color.black.opacity(0.5)
        static let backgroundOpacity = Color(.systemBackground).opacity(0.8)
    }
    
    struct Fonts {
        static let title = Font.system(size: 18, weight: .bold)
        static let titleItalic = Font.system(size: 18, weight: .bold).italic()
        static let body = Font.system(size: 14, weight: .regular)
        static let caption = Font.system(size: 12, weight: .light)
    }
    
    struct Icons {
        static let heartFill = "heart.fill"
        static let heart = "heart"
        static let bubbleRight = "bubble.right"
        static let speakerSlashFill = "speaker.slash.fill"
        static let speakerFill = "speaker.fill"
    }
    
    struct Sizes {
        static let profilePicture: CGFloat = 40
        static let paginationDot: CGFloat = 6
    }
    
    struct Media {
        static let image = "image"
        static let video = "video"
        static let defaultResolution = "1024x1024"
    }
    
    struct Counts {
        static let thousand = 1000
    }
}
