//
//  ProcessListHostProtocolImpl.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation
import ProcessListToAppShared
import ProcessManagerCore

final class ProcessListHostProtocolImpl: ProcessListHostProtocol {
  private let errorHandler: ErrorHandler
  
  init(errorHandler: ErrorHandler) {
    self.errorHandler = errorHandler
  }
  
  func onError(withError: Error) {
    errorHandler.handle(withError)
  }
}
