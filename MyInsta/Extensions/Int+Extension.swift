//
//  Int+Extension.swift
//  MyInsta
//
//  Created by Jeslin Johnson on 22/03/2025.
//

import Foundation

extension Int {
    func formatCount() -> String {
        if self >= MIConstants.Counts.thousand {
            return "\(Double(self) / Double(MIConstants.Counts.thousand))K"
        } else {
            return "\(self)"
        }
    }
}
