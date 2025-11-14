//
//  MockPriceFeedManager.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation
import Combine

final class MockPriceFeedManager {
  private let symbols: [StockInfo] = StockSymbols.all
  private let socketHandler: WebSocketHandler<StockPriceFeed>
  private var timerCancellable: AnyCancellable?
  
  init(socketHandler: WebSocketHandler<StockPriceFeed>) {
    self.socketHandler = socketHandler
    startFeeder()
  }
  
  func startFeeder() {
    socketHandler.connect()
    startTimer()
  }
  
  func stopFeeder() {
    socketHandler.disconnect()
    stopTimer()
  }
  
  private func startTimer() {
    timerCancellable = Timer.publish(every: 2.0, on: .main, in: .default)
      .autoconnect()
      .sink { [weak self] _ in
        self?.prepareMockPriceFeed()
      }
  }
  
  private func stopTimer() {
    timerCancellable?.cancel()
    timerCancellable = nil
  }
  
  private func prepareMockPriceFeed() {
    self.symbols.forEach { item in
      let newPrice = Double.random(in: 100...1000)
      let feed = StockPriceFeed(symbol: item.symbol,
                                name: item.company,
                                price: newPrice,
                                timestamp: Date())
      postStockPrice(feed)
    }
  }
  
  private func postStockPrice(_ feed: StockPriceFeed) {
    socketHandler.sendMessage(feed)
  }
  
}
