//
//  ProcessListErrorHandlerProxy.swift
//  ProcessListXPCService
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation
import ProcessListToAppShared
import ProcessManagerCore

final class ProcessListErrorHandlerProxy: ErrorHandler {
 var subject: ProcessListHostProtocol?
  
  func handle(_ error: Error) {
    guard let hostObject = subject else {
      NSLog("XPCDebug: ProcessKillerErrorHandlerProxy unable to forward error handling to host")
      return
    }
    hostObject.onError(withError: error)
  }
}
