//
//  RemoveDuplicatesPublishedAdapter.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Combine
import Foundation

public final class RemoveDuplicatesPublishedAdapter<P: Publisher>: ObservableObject where P.Output: Equatable {
  @Published public var value: P.Output
  
  private var cancelBag = Set<AnyCancellable>()
  
  public init(
    defaultValue: @autoclosure () -> P.Output,
    publisher: @autoclosure () -> P
  ) {
    self.value = defaultValue()
    publisher()
      .receive(on: RunLoop.main)
      .removeDuplicates()
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { value in
          self.value = value
      })
    .store(in: &cancelBag)
  }
}
