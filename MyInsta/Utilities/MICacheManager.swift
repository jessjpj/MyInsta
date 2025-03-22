//
//  MICacheManager.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 23/03/2025.
//

import Foundation

class MICacheManager: MICacheManagerProtocol {
    static let shared = MICacheManager()

    private let postsKey = "cachedPosts"
    private let cacheExpiryKey = "cacheExpiry"

    private init() {}

    func savePosts(_ posts: [MIPost]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(posts)
            UserDefaults.standard.set(data, forKey: postsKey)
            UserDefaults.standard.set(Date().addingTimeInterval(86400), forKey: cacheExpiryKey)
        } catch {
            print("Failed to encode and save posts: \(error)")
        }
    }

    func loadPosts() -> [MIPost]? {
        guard isCacheValid() else {
            clearCache()
            return nil
        }
        guard let data = UserDefaults.standard.data(forKey: postsKey) else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let posts = try decoder.decode([MIPost].self, from: data)
            return posts
        } catch {
            print("Failed to decode posts: \(error)")
            return nil
        }
    }

    func clearCache() {
        UserDefaults.standard.removeObject(forKey: postsKey)
        UserDefaults.standard.removeObject(forKey: cacheExpiryKey)
    }

    func isCacheValid() -> Bool {
        guard let expiryDate = UserDefaults.standard.object(forKey: cacheExpiryKey) as? Date else {
            return false
        }
        return Date() < expiryDate
    }
}
