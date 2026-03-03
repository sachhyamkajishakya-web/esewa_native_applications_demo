//
//  Item.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 03/03/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
