//
//  MIJsonLoader.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 21/03/2025.
//

import Foundation

class MIJSONLoader {
    static func loadJSON<T: Decodable>(filename: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Failed to locate \(filename) in app bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            print("Failed to decode \(filename): \(error)")
            return nil
        }
    }
}
