//
//  LoggingErrorHandler.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation

public final class LoggingErrorHandler: ErrorHandler {
  private let subject: ErrorHandler
  
  public init(subject: ErrorHandler) {
    self.subject = subject
  }
  
  public func handle(_ error: Error) {
    subject.handle(error)
    NSLog("XPCDebug: Error occured \(error.localizedDescription)")
  }
}
