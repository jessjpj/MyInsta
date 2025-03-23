//
//  MIMockDataService.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation
import Combine

class MIMockDataService: MIDataService {
    var shouldFail = false
    var mockPosts: [MIPost] = []

    func fetchPosts() -> AnyPublisher<[MIPost], Error> {
        if shouldFail {
            return Fail(error: NSError(domain: "TestError", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        mockPosts = generateMockData()
        return Just(mockPosts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func generateMockData() -> [MIPost] {
        return [
            MIPost(id: "1",
                   user: .init(id: "1",
                               name: "test user",
                               avatarThumb: "https://storage.googleapis.com/myinsta-6fc59.firebasestorage.app/ProfilePics/pexels-sinileunen-6652928.jpg"),
                   caption: "Post 1",
                   media: [.init(url: "https://storage.googleapis.com/myinsta-6fc59.firebasestorage.app/istockphoto-2156942049-1024x1024.jpg",
                                 type: "image",
                                 resolution: "1024x1024")],
                   likes: 10,
                   comments: [.init(user: .init(id: "19",
                                                name: "mike_t",
                                                avatarThumb: "https://storage.googleapis.com/myinsta-6fc59.firebasestorage.app/ProfilePics/pexels-sinileunen-6652959.jpg"),
                                    text: "wowwww")]),
            MIPost(id: "1",
                   user: .init(id: "1",
                               name: "test user",
                               avatarThumb: "https://storage.googleapis.com/myinsta-6fc59.firebasestorage.app/ProfilePics/pexels-sinileunen-6652928.jpg"),
                   caption: "Post 2",
                   media: [.init(url: "https://storage.googleapis.com/myinsta-6fc59.firebasestorage.app/istockphoto-2161147879-640_adpp_is.mp4",
                                 type: "image",
                                 resolution: "1024x1024")],
                   likes: 10,
                   comments: [.init(user: .init(id: "19",
                                                name: "mike_t",
                                                avatarThumb: "https://storage.googleapis.com/myinsta-6fc59.firebasestorage.app/ProfilePics/pexels-sinileunen-6652959.jpg"),
                                    text: "wowwww")]),
        ]
    }
}
