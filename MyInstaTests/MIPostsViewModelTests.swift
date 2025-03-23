//
//  MIPostsViewModelTests.swift
//  MyInstaTests
//
//  Created by Jeslin Johnson on 23/03/2025.
//

import XCTest
import Combine
@testable import MyInsta

class MIPostsViewModelTests: XCTestCase {
    var viewModel: MIPostsViewModel!
    var mockDataService: MIMockDataService!
    var mockCacheManager: MIMockCacheManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockDataService = MIMockDataService()
        mockCacheManager = MIMockCacheManager()
        viewModel = MIPostsViewModel(dataService: mockDataService, cacheManager: mockCacheManager)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataService = nil
        mockCacheManager = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchPostsSuccess() {
        let mockPosts = [MIPost(id: "1", user: MIUser(id: "1", name: "User1", avatarThumb: ""), caption: "Post 1", media: [], likes: 10, comments: [])]
        mockDataService.mockPosts = mockPosts
        
        let expectation = XCTestExpectation(description: "Fetch posts successfully")
        
        viewModel.$posts
            .dropFirst()
            .sink { posts in
                XCTAssertEqual(posts, mockPosts)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchPosts()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.isLoaded)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchPostsFailure() {
        mockDataService.shouldFail = true
        
        let expectation = XCTestExpectation(description: "Fetch posts with error")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchPosts()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isLoaded)
    }

    func testLoadCachedPosts() {
        let mockPosts = [MIPost(id: "1", user: MIUser(id: "1", name: "User1", avatarThumb: ""), caption: "Post 1", media: [], likes: 30, comments: [])]
        mockCacheManager.savedPosts = mockPosts
        mockCacheManager.shouldReturnValidCache = true
        
        viewModel.fetchPosts()
        
        XCTAssertEqual(viewModel.posts, mockPosts)
        XCTAssertTrue(viewModel.isLoaded)
    }

    func testCacheInvalidation() {
        mockCacheManager.shouldReturnValidCache = false
        
        viewModel.fetchPosts()
        
        XCTAssertTrue(viewModel.posts.isEmpty)
        XCTAssertFalse(viewModel.isLoaded)
    }
}
