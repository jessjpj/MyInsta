//
//  MICacheManagerTests.swift
//  MyInstaTests
//
//  Created by Jeslin Johnson on 23/03/2025.
//

import XCTest
@testable import MyInsta

class MICacheManagerTests: XCTestCase {
    var cacheManager: MICacheManager!
    
    override func setUp() {
        super.setUp()
        cacheManager = MICacheManager.shared
        cacheManager.clearCache()
    }
    
    override func tearDown() {
        cacheManager.clearCache()
        super.tearDown()
    }

    func testSaveAndLoadPosts() {
        let mockPosts = [MIPost(id: "1", user: MIUser(id: "1", name: "User1", avatarThumb: ""), caption: "Post 1", media: [], likes: 10, comments: [])]
        
        cacheManager.savePosts(mockPosts)
        let loadedPosts = cacheManager.loadPosts()
        
        XCTAssertEqual(loadedPosts, mockPosts)
    }

    func testCacheValidity() {
        let mockPosts = [MIPost(id: "1", user: MIUser(id: "1", name: "User1", avatarThumb: ""), caption: "Post 1", media: [], likes: 20, comments: [])]
        
        cacheManager.savePosts(mockPosts)
        XCTAssertTrue(cacheManager.isCacheValid())

        let expiredDate = Date().addingTimeInterval(-86400)
        UserDefaults.standard.set(expiredDate, forKey: "cacheExpiry")
        XCTAssertFalse(cacheManager.isCacheValid())
    }

    func testClearCache() {
        let mockPosts = [MIPost(id: "1", user: MIUser(id: "1", name: "User1", avatarThumb: ""), caption: "Post 1", media: [], likes: 698, comments: [])]
        
        cacheManager.savePosts(mockPosts)
        cacheManager.clearCache()
        
        XCTAssertNil(cacheManager.loadPosts())
    }
}
