//
//  ProcessPublisherAdapterImpl.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Combine
import ProcessListToAppShared

@available(macOS 10.15, *)
final class AllProcessesPublisherAdapterImpl: ProcessesPublisherAdapter {
  private let processList: ProcessListXPC
  
  init(processList: ProcessListXPC) {
    self.processList = processList
  }
  
  func subject() -> AnyPublisher<[ProcessModel], Error> {
    return Future() { promise in
      self.processList.listAll(
        reply: { promise(.success($0)) }
      )
    }
    .eraseToAnyPublisher()
  }
}
