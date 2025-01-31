//
//  Item.swift
//  TechGlances
//
//  Created by An Nguyễn on 31/1/25.
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
