//
//  ProcessKillerXPCImpl.swift
//  com.alex.ProcessKIllerXPC
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation
import SignalSender
import ProcessKillerToAppShared
import ProcessManagerCore

final class ProcessKillerXPCImpl: ProcessKillerXPC {
  private let signalSender: SignalSender
  private let errorHandler: ErrorHandler
    
  init(
    signalSender: SignalSender,
    errorHandler: ErrorHandler
  ) {
    self.signalSender = signalSender
    self.errorHandler = errorHandler
  }
  
  func kill(withID id: Int) {
    guard signalSender.send(.kill, to: Int32(id)) else {
      return errorHandler.handle(KillError.unableToKillProcess)
    }
  }
}
