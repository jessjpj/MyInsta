//
//  MIPostsViewModel.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation
import Combine

class MIPostsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isLoaded = false
    @Published var errorMessage: String?
    @Published var posts: [MIPost] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService: MIDataService
    
    init(dataService: MIDataService, cacheManager: MICacheManagerProtocol = MICacheManager.shared) {
        self.dataService = dataService
        fetchPosts()
    }
    
    func fetchPosts() {
        isLoading = true
        errorMessage = nil

        if let cachedPosts = MICacheManager.shared.loadPosts() {
            self.posts = cachedPosts
            self.isLoaded = true
        }

        dataService.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] posts in
                    self?.isLoaded = true
                    self?.posts = posts
                    MICacheManager.shared.savePosts(posts)
                }
            )
            .store(in: &cancellables)
    }
}
