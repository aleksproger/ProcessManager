//
//  ProcessPublisherAdapter.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Combine
import ProcessListToAppShared

@available(macOS 10.15, *)
protocol ProcessesPublisherAdapter {
  func subject() -> AnyPublisher<[ProcessModel], Error>
}
