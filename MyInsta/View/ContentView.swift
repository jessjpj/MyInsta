//
//  ContentView.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: MIPostsViewModel
    
    init(viewModel: StateObject<MIPostsViewModel>?, cacheManager: MICacheManagerProtocol) {
        if let viewModel = viewModel {
            _viewModel = viewModel
        } else {
            let service: MIDataService = MIDataServiceSelector().decideDataService()
            _viewModel = StateObject(wrappedValue: MIPostsViewModel(dataService: service, cacheManager: cacheManager))
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: MIConstants.padding) {
                    ForEach(viewModel.posts) { post in
                        MIPostView(post: post)
                    }
                }
            }
            .refreshable {
                viewModel.fetchPosts()
            }
            .navigationBarItems(leading:
                                    Text(MIConstants.appName)
                .font(MIConstants.Fonts.titleItalic)
            )
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
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockService = MIMockDataService()
        let viewModel = StateObject(wrappedValue: MIPostsViewModel(dataService: mockService))
        ContentView(viewModel: viewModel, cacheManager: MICacheManager.shared)
    }
}
