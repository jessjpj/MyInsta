//
//  MIMediaUtility.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation
import UIKit

class MIMediaUtility {
    static func calculateMediaHeight(_ resolution: String) -> CGFloat {
        let components = resolution.components(separatedBy: MIConstants.Media.defaultResolution.components(separatedBy: "x")[1])
        guard components.count == 2,
              let width = Double(components[0]),
              let height = Double(components[1]) else {
            return MIConstants.mediaAspectRatio
        }
        let aspectRatio = height / width
        return UIScreen.main.bounds.width * CGFloat(aspectRatio)
    }
}
