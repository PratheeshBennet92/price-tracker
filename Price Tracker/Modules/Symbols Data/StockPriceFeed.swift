//
//  StockPriceFeed.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation

struct StockPriceFeed: Codable {
  let symbol: String
  let name: String
  let price: Double
  let timestamp: Date
}
