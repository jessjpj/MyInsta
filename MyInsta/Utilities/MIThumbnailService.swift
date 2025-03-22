//
//  MIThumbnailService.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import AVFoundation
import UIKit

class MIThumbnailService {
    static let shared = MIThumbnailService()
    
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ThumbnailCache")
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
    
    func generateThumbnail(for videoURL: String, completion: @escaping (UIImage?) -> Void) {
        let fileName = URL(string: videoURL)!.lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(fileName)

        if let cachedThumbnail = cache.object(forKey: videoURL as NSString) {
            completion(cachedThumbnail)
            return
        }

        if fileManager.fileExists(atPath: fileURL.path) {
            if let diskThumbnail = UIImage(contentsOfFile: fileURL.path) {
                cache.setObject(diskThumbnail, forKey: videoURL as NSString)
                completion(diskThumbnail)
                return
            }
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVAsset(url: URL(string: videoURL)!)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true

            do {
                let cgImage = try generator.copyCGImage(at: CMTime(value: 1, timescale: 60), actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)

                self.cache.setObject(thumbnail, forKey: videoURL as NSString)

                if let data = thumbnail.pngData() {
                    try data.write(to: fileURL)
                }
                
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            } catch {
                print("Error generating thumbnail: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

extension MIThumbnailService {
    func clearCache() {
        cache.removeAllObjects()
        do {
            try fileManager.removeItem(at: cacheDirectory)
            createCacheDirectory()
        } catch {
            print("Failed to clear cache: \(error)")
        }
    }
}
