//
//  MIPost.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import Foundation

struct MIPostsContainer: Codable {
    let posts: [MIPost]
}

struct MIPost: Codable, Identifiable, Equatable {
    static func == (lhs: MIPost, rhs: MIPost) -> Bool {
        return lhs.id == rhs.id && lhs.user == rhs.user && lhs.caption == rhs.caption && lhs.media == rhs.media && lhs.likes == rhs.likes && lhs.comments == rhs.comments
    }
    
    let id: String
    let user: MIUser
    let caption: String
    let media: [MIMedia]
    var likes: Int
    let comments: [MIComment]
}
