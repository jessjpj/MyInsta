//
//  MIJSONService.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation
import Combine

class JSONService: MIDataService {
    func fetchPosts() -> AnyPublisher<[MIPost], Error> {
        guard let postsContainer = MIJSONLoader.loadJSON(filename: "Posts", as: MIPostsContainer.self) else {
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil)).eraseToAnyPublisher()
        }
        let posts = postsContainer.posts
        return Just(posts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
