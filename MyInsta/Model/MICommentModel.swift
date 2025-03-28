//
//  MICommentModel.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import Foundation

struct MIComment: Codable, Equatable {
    let user: MIUser
    let text: String
}
