//
//  IntervalPublisher.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Combine
import Foundation

@available(macOS 11.0, *)
public struct IntervalPublisher<O, F: Error>: Publisher {
  public typealias Output = O
  public typealias Failure = F
  
  private let publisher: () -> AnyPublisher<Output, Failure>
  private let interval: TimeInterval
  
  public init(
    interval: TimeInterval,
    publisher: @autoclosure @escaping () -> AnyPublisher<Output, Failure>
  ) {
    self.publisher = publisher
    self.interval = interval
  }
  
  public func receive<S: Subscriber>(
    subscriber: S
  ) where Failure == S.Failure, Output == S.Input {
    let subscription = IntervalSubscription<S, AnyPublisher<Output, Failure>>()
    subscription.subscriber = subscriber
    subscriber.receive(subscription: subscription)
    subscription.start(
      using: publisher(),
      interval: interval
    )
  }
}

@available(macOS 11.0, *)
fileprivate class IntervalSubscription<S: Subscriber, P: Publisher>: Subscription
  where S.Input == P.Output, S.Failure == P.Failure
{
  private var cancelBag = Set<AnyCancellable>()
  
  var subscriber: S?
  
  func request(_ demand: Subscribers.Demand) {}
  
  func cancel() {
    subscriber = nil
    cancelBag = []
  }
  
  func start(
    using publisher: @autoclosure @escaping () -> P,
    interval: TimeInterval
) {
    Timer
      .publish(every: interval, on: .main, in: .default)
      .autoconnect()
      .flatMap { _ in publisher() }
      .sink(
        receiveCompletion: { self.subscriber?.receive(completion: $0) },
        receiveValue: { _ = self.subscriber?.receive($0) }
      )
      .store(in: &cancelBag)
  }
}
