//
//  StockFeedRow.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation

enum PriceDirection {
  case up
  case down
  case same
  
  static func state(oldPrice: Double?, newPrice: Double) -> Self {
    guard let oldPrice = oldPrice else {
      return .same
    }
    
    if newPrice > oldPrice {
      return .up
    } else if newPrice < oldPrice {
      return .down
    } else {
      return .same
    }
  }
}

struct StockFeedRow: Identifiable {
  let id = UUID()
  let symbol: String
  let company: String
  let price: Double
  let direction: PriceDirection
}
