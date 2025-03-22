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
        let service: MIDataService = MIFirestoreService() // Switch to JSONService() for offline mode
        _viewModel = StateObject(wrappedValue: MIPostsViewModel(dataService: service))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: MIConstants.padding) {
                    ForEach(viewModel.posts) { post in
                        MIPostView(post: post)
                    }
                }
                .padding(.horizontal, MIConstants.padding)
            }
            .refreshable {
                await viewModel.fetchPosts()
            }
            .navigationTitle(MIConstants.appName)
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView(MIConstants.loadingText)
                            .padding()
                            .background(MIConstants.Colors.backgroundOpacity)
                            .cornerRadius(MIConstants.cornerRadius)
                    }
                }
            )
            .alert(MIConstants.errorTitle, isPresented: .constant(viewModel.errorMessage != nil)) {
                Button(MIConstants.okButtonText, role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? MIConstants.unknownError)
            }
        }
    }
}
