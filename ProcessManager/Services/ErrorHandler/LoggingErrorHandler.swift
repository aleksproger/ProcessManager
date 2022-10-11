//
//  LoggingErrorHandler.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation

final class LoggingErrorHandler: ErrorHandler {
  private let subject: ErrorHandler
  
  init(subject: ErrorHandler) {
    self.subject = subject
  }
  
  func handle(_ error: Error) {
    subject.handle(error)
    NSLog("XPCDebug: Error occured \(error.localizedDescription)")
  }
}
