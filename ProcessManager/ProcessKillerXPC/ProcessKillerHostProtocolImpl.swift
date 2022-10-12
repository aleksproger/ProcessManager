//
//  ProcessKillerHostProtocolImpl.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation
import ProcessKillerToAppShared
import ProcessManagerCore

final class ProcessKillerHostProtocolImpl: ProcessKillerHostProtocol {
  private let errorHandler: ErrorHandler
  
  init(errorHandler: ErrorHandler) {
    self.errorHandler = errorHandler
  }
  
  func onError(withError: Error) {
    errorHandler.handle(withError)
  }
}
