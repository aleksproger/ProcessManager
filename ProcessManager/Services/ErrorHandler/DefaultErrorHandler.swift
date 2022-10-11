//
//  DefaultErrorHandler.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation
import AppKit

final class DefaultErrorHandler: ErrorHandler {
  func handle(_ error: Error) {
    let alert = NSAlert()
    alert.messageText = "Error Occured"
    alert.informativeText = error.localizedDescription
    alert.alertStyle = .warning
    alert.addButton(withTitle: "OK")
    alert.runModal()
  }
}
