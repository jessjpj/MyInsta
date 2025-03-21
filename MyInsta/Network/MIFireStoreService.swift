//
//  MIFireStoreService.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import Combine

class MIFirestoreService: MIDataService {
    private let db = Firestore.firestore()
    
    func fetchPosts() -> AnyPublisher<[MIPost], Error> {
        Future { promise in
            self.db.collection("posts").getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let documents = snapshot?.documents {
                    let posts = documents.compactMap { document in
                        try? document.data(as: MIPost.self)
                    }
                    promise(.success(posts))
                } else {
                    promise(.success([]))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

