//
//  MIFirebaseUploader.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import Foundation
import FirebaseFirestore

class MIFirestoreUploader {
    private let db = Firestore.firestore()

    func uploadPosts(completion: @escaping (Bool, Error?) -> Void) {
        guard let postsContainer = MIJSONLoader.loadJSON(filename: "Posts", as: MIPostsContainer.self) else {
            completion(false, NSError(domain: "FirestoreUploader", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load posts from JSON."]))
            return
        }
        let posts = postsContainer.posts

        let dispatchGroup = DispatchGroup()

        for post in posts {
            dispatchGroup.enter()
            let postRef = db.collection("posts").document(post.id)
            do {
                try postRef.setData(from: post) { error in
                    if let error = error {
                        print("Error uploading post \(post.id): \(error)")
                    } else {
                        print("Uploaded post with ID: \(post.id)")
                    }
                    dispatchGroup.leave()
                }
            } catch {
                print("Error uploading post \(post.id): \(error)")
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(true, nil)
        }
    }
}
