//
//  MIDataService.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Combine

protocol MIDataService {
    func fetchPosts() -> AnyPublisher<[MIPost], Error>
}
