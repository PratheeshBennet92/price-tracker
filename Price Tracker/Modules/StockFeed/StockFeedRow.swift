//
//  StockFeedRow.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation

struct StockFeedRow: Identifiable {
  let id = UUID()
  let symbol: String
  let company: String
  let price: Double
  let direction: PriceDirection
  let timestamp: Date
}
