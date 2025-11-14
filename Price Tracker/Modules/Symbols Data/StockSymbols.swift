//
//  StockSymbols.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//
struct StockInfo {
  let symbol: String
  let company: String
}

enum StockSymbols {
  static let all: [StockInfo] = [
    StockInfo(symbol: "AAPL", company: "Apple Inc."),
    StockInfo(symbol: "MSFT", company: "Microsoft Corporation"),
    StockInfo(symbol: "AMZN", company: "Amazon.com Inc."),
    StockInfo(symbol: "GOOG", company: "Alphabet Inc. (Google)"),
    StockInfo(symbol: "META", company: "Meta Platforms Inc."),
    StockInfo(symbol: "TSLA", company: "Tesla Inc."),
    StockInfo(symbol: "NVDA", company: "NVIDIA Corporation"),
    StockInfo(symbol: "NFLX", company: "Netflix Inc."),
    StockInfo(symbol: "AMD", company: "Advanced Micro Devices"),
    StockInfo(symbol: "INTC", company: "Intel Corporation"),
    StockInfo(symbol: "ORCL", company: "Oracle Corporation"),
    StockInfo(symbol: "IBM", company: "IBM Corporation"),
    StockInfo(symbol: "CRM", company: "Salesforce Inc."),
    StockInfo(symbol: "PYPL", company: "PayPal Holdings"),
    StockInfo(symbol: "SHOP", company: "Shopify Inc."),
    StockInfo(symbol: "SQ", company: "Block Inc. (formerly Square)"),
    StockInfo(symbol: "BABA", company: "Alibaba Group"),
    StockInfo(symbol: "TSM", company: "Taiwan Semiconductor Manufacturing"),
    StockInfo(symbol: "AVGO", company: "Broadcom Inc."),
    StockInfo(symbol: "ADBE", company: "Adobe Inc."),
    StockInfo(symbol: "COST", company: "Costco Wholesale"),
    StockInfo(symbol: "WMT", company: "Walmart Inc."),
    StockInfo(symbol: "JPM", company: "JPMorgan Chase & Co."),
    StockInfo(symbol: "BAC", company: "Bank of America"),
    StockInfo(symbol: "XOM", company: "Exxon Mobil Corporation")
  ]
  
  static func getCompany(forSymbol symbol: String) -> String? {
    return all.first(where: { $0.symbol == symbol })?.company
  }
}
