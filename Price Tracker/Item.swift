//
//  Item.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
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
