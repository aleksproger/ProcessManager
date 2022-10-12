//
//  ProcessKillerErrorHandlerProxy.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation
import ProcessKillerToAppShared
import ProcessManagerCore

final class ProcessKillerErrorHandlerProxy: ErrorHandler {
 var subject: ProcessKillerHostProtocol?
  
  func handle(_ error: Error) {
    guard let hostObject = subject else {
      NSLog("XPCDebug: ProcessKillerDelegateProxy unable to forward error handling to host")
      return
    }
    hostObject.onError(withError: error)
  }
}
