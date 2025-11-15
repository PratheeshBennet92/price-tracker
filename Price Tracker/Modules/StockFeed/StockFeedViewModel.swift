//
//  StockFeedViewModel.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation
import Combine
import SwiftUI


class StockFeedViewModel: ObservableObject {
  @Published var connectionState: WebSocketConnectionState = .disconnected
  @Published var stocks: [StockFeedRow] = []
  private let socketHandler: WebSocketHandler<StockPriceFeed>
  private var latestBySymbol: [String: StockFeedRow] = [:]
  private var connectionStateCancellable: AnyCancellable?
  private var messagesCancellable: AnyCancellable?
  
  init(socketHandler: WebSocketHandler<StockPriceFeed>) {
    self.socketHandler = socketHandler
  }
  
  private func bindSocket() {
    
    connectionStateCancellable = socketHandler.$connectionState
          .assign(to: \.connectionState, on: self)
 
    
    messagesCancellable = socketHandler.messages
      .receive(on: DispatchQueue.main)
      .collect(.byTime(DispatchQueue.main, .milliseconds(2000)))
      .sink { [weak self] stockFeed in
        stockFeed.forEach({
          self?.handleIncoming($0)
        })
      }
  }
  
  func startUIListening() {
    bindSocket()
  }
  
  func stopUIListening() {
    connectionStateCancellable?.cancel()
    messagesCancellable?.cancel()
    connectionStateCancellable = nil
    messagesCancellable = nil
  }
  
  func startPolling() {
    socketHandler.connect()
    socketHandler.receiveMessages()
  }
  
  func stopPolling() {
    socketHandler.disconnect()
  }
  
  deinit {
    connectionStateCancellable?.cancel()
    messagesCancellable?.cancel()
  }
  
  private func handleIncoming(_ feed: StockPriceFeed) {
    //debugPrint(feed)
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


