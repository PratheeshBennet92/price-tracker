//
//  StockFeedViewModel.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation
import Combine

@MainActor
class StockFeedViewModel: ObservableObject {
  @Published var connectionState: WebSocketConnectionState = .disconnected
  @Published var stocks: [StockFeedRow] = []
  private var socketHandler: WebSocketHandler<StockPriceFeed> = WebSocketHandler<StockPriceFeed>()
  private var latestBySymbol: [String: StockFeedRow] = [:]
  private var connectionStateCancellable: AnyCancellable?
  private var messagesCancellable: AnyCancellable?
  
  init() {
    bindSocket()
  }
  
  private func bindSocket() {
    
    connectionStateCancellable = socketHandler.$connectionState
          .assign(to: \.connectionState, on: self)
 
    
    messagesCancellable = socketHandler.messages
      .receive(on: DispatchQueue.main)
      .sink { [weak self] stockFeed in
        self?.handleIncoming(stockFeed)
      }
  }
  
  func startPolling() {
    socketHandler.connect()
  }
  
  func stopPolling() {
    socketHandler.disconnect()
  }
  
  deinit {
    connectionStateCancellable?.cancel()
    connectionStateCancellable = nil
    messagesCancellable?.cancel()
    messagesCancellable = nil
  }
  
  private func handleIncoming(_ feed: StockPriceFeed) {
    debugPrint(feed)
    let symbol = feed.symbol
    let newPrice = feed.price
    let company = StockSymbols.getCompany(forSymbol: symbol) ?? "N/A"
    let oldRow = latestBySymbol[symbol]
    let oldPrice = oldRow?.price
    
    let direction = PriceDirection.state(oldPrice: oldPrice, newPrice: newPrice)
    
    let row = StockFeedRow(
      symbol: symbol,
      company: company,
      price: newPrice,
      direction: direction
    )
    
    latestBySymbol[symbol] = row
    stocks = latestBySymbol.values.sorted { $0.price > $1.price }
  }
  
  
}
