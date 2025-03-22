//
//  MIVideoCacheService.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation
import Combine

class MIVideoCacheService {
    static let shared = MIVideoCacheService()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("VideoCache")
        createCacheDirectory()
    }
    
    private func createCacheDirectory() {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create cache directory: \(error)")
            }
        }
    }
    
    func cachedVideoURL(for url: String) -> URL? {
        let fileName = URL(string: url)!.lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            return fileURL
        }
        return nil
    }
    
    func cacheVideo(from url: String, completion: @escaping (URL?) -> Void) {
        let fileName = URL(string: url)!.lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            completion(fileURL)
            return
        }
        
        let task = URLSession.shared.downloadTask(with: URL(string: url)!) { tempURL, response, error in
            if let tempURL = tempURL {
                do {
                    try self.fileManager.moveItem(at: tempURL, to: fileURL)
                    completion(fileURL)
                } catch {
                    print("Failed to cache video: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
