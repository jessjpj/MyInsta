//
//  MICacheManagerProtocol.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 23/03/2025.
//

import Foundation

protocol MICacheManagerProtocol {
    func savePosts(_ posts: [MIPost])
    func loadPosts() -> [MIPost]?
    func isCacheValid() -> Bool
    func clearCache()
}
