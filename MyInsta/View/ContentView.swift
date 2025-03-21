//
//  ContentView.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: MIPostsViewModel
    
    init() {
        let service: MIDataService = MIFirestoreService() // Switch this to JSONService() for offline mode
        _viewModel = StateObject(wrappedValue: MIPostsViewModel(dataService: service))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading posts...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.isLoaded {
                List(viewModel.posts) { post in
                    Text(post.caption)
                }
            } else {
                Text("No posts available.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle("Posts")
    }
}
