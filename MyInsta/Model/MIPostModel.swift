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

struct MIPost: Codable, Identifiable {
    let id: String
    let user: String
    let caption: String
    let media: [MIMedia]
    let likes: Int
    let comments: [MIComment]
}
