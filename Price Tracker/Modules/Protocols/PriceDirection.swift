//
//  PriceDirection.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

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
