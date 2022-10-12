//
//  DefaultErrorHandler.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation
import AppKit

public final class DefaultErrorHandler: ErrorHandler {
  private let mainThreadRunner: MainThreadRunner
  
  public init(mainThreadRunner: @escaping MainThreadRunner = onMainThreadAsync) {
    self.mainThreadRunner = mainThreadRunner
  }
  
  public func handle(_ error: Error) {
    mainThreadRunner {
      let alert = NSAlert()
      alert.messageText = "Error Occured"
      alert.informativeText = error.localizedDescription
      alert.alertStyle = .warning
      alert.addButton(withTitle: "OK")
      alert.runModal()
    }
  }
}
