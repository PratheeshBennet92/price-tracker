//
//  StockFeedDetailViewModel.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//
import Foundation
import Combine


class StockFeedDetailViewModel: ObservableObject {
  @Published var stockFeedRow: StockFeedRow
  @Published var connectionState: WebSocketConnectionState = .disconnected
  private let socketHandler: WebSocketHandler<StockPriceFeed>
  private var cancellables: Set<AnyCancellable> = []
  init(socketHandler: WebSocketHandler<StockPriceFeed>,
       stockFeedRow: StockFeedRow) {
    self.socketHandler = socketHandler
    self.stockFeedRow = stockFeedRow
    bindSocket()
  }
  
  private func bindSocket() {
    socketHandler.$connectionState
      .assign(to: \.connectionState, on: self)
      .store(in: &cancellables)
    
    socketHandler.messages
      .receive(on: DispatchQueue.main)
      .collect(.byTime(DispatchQueue.main, .milliseconds(1000)))
      .sink { [weak self] stockFeed in
        stockFeed.forEach({
          self?.handleIncoming($0)
        })
      }.store(in: &cancellables)
  }
  
  private func handleIncoming(_ feed: StockPriceFeed) {
    let currentSymbol = stockFeedRow.symbol
    if feed.symbol == currentSymbol {
      let oldPrice = stockFeedRow.price
      let newPrice = feed.price
      let direction = PriceDirection.state(oldPrice: oldPrice, newPrice: newPrice)
      let updateedFeed = StockFeedRow(symbol: feed.symbol,
                                      company: feed.name,
                                      price: feed.price,
                                      direction: direction)
      self.stockFeedRow = updateedFeed
    }
  }
}
