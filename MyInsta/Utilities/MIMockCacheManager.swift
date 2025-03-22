//
//  MIMockCacheManager.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 23/03/2025.
//

import Foundation

class MIMockCacheManager: MICacheManagerProtocol {
    var savedPosts: [MIPost] = []
    var shouldReturnValidCache = true
    
    func savePosts(_ posts: [MIPost]) {
        savedPosts = posts
    }
    
    func loadPosts() -> [MIPost]? {
        return shouldReturnValidCache ? savedPosts : nil
    }
    
    func isCacheValid() -> Bool {
        return shouldReturnValidCache
    }
    
    func clearCache() {
        savedPosts = []
    }
}
