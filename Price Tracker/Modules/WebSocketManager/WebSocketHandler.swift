//
//  WebSocketHandler.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import Foundation
import Combine
enum WebSocketConnectionError: Error {
  case technical
  case unknown
  var description: String? {
    switch self {
    case .technical: return "WebSocket technical error occurred."
    case .unknown: return "Unknown WebSocket error occurred."
    }
  }
}
enum WebSocketConnectionState {
  case disconnected
  case connecting
  case connected
  case failed(WebSocketConnectionError)
  
  var connectionState: String {
    switch self {
    case .disconnected: return "Disconnected"
    case .connecting: return "Connecting"
    case .connected: return "Connected"
    case .failed(let error): return "Failed (\(error.localizedDescription))"
    }
  }
}

final class WebSocketHandler<T: Codable>: ObservableObject {
  
  @Published private(set) var connectionState: WebSocketConnectionState = .disconnected
  let messages: PassthroughSubject<T, Never> = PassthroughSubject<T, Never>()
  private let url: URL
  private let urlSession: URLSession
  private var task: URLSessionWebSocketTask?
  private var isConnectionClosed = false
  
  init (url: URL = URL(string: "wss://ws.postman-echo.com/raw")!,
        urlSession: URLSession = URLSession(configuration: .default)
  ) {
    self.url = url
    self.urlSession = urlSession
  }
  
  func connect() {
    isConnectionClosed = false
    updateState(.connecting)
    task = urlSession.webSocketTask(with: url)
    task?.resume()
    updateState(.connected)
  }
  
  func disconnect() {
    isConnectionClosed = true
    task?.cancel(with: .goingAway, reason: nil)
    task = nil
    updateState(.disconnected)
  }
  
  func sendMessage(_ message: T) {
    do {
      let data = try JSONEncoder().encode(message)
      guard let jsonString = String(data: data, encoding: .utf8) else { return }
      send(text: jsonString)
      debugPrint("Sent Message:", jsonString)
    } catch {
      handleError(error)
    }
  }
  
  private func send(text: String) {
    let message = URLSessionWebSocketTask.Message.string(text)
    task?.send(message) { [weak self] error in
      if let error {
        self?.handleError(error)
        debugPrint("Error", error)
      } else {
        debugPrint("Send Success")
      }
     
    }
  }
  
  func receiveMessages() {
    task?.receive { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let message):
        switch message {
        case .string(let text):
          if let data = text.data(using: .utf8),
             let decoded = try? JSONDecoder().decode(T.self, from: data) {
            self.messages.send(decoded)
            debugPrint("Received Message:", decoded)
          }
        case .data(let data):
          if let decoded = try? JSONDecoder().decode(T.self, from: data) {
            self.messages.send(decoded)
            debugPrint("Received Message:", decoded)
          }
        @unknown default:
          break
        }
        self.receiveMessages()
      case .failure(let error):
        self.handleError(error)
      }
    }
  }
  
  private func handleError(_ error: Error) {
    if isConnectionClosed {
      updateState(.disconnected)
    } else {
      if error is URLError {
        updateState(.failed(WebSocketConnectionError.technical))
      } else {
        updateState(.failed(WebSocketConnectionError.unknown))
      }
    }
    debugPrint(error)
  }
  
  private func updateState(_ newState: WebSocketConnectionState) {
    DispatchQueue.main.async {
      self.connectionState = newState
    }
  }
  
}
