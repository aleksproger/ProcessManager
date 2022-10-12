//
//  ProcessKillerXPCImpl.swift
//  com.alex.ProcessKIllerXPC
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation
import SignalSender

final class ProcessKillerXPCImpl: ProcessKillerXPC {
  private let signalSender: SignalSender
    
  init(signalSender: SignalSender) {
    self.signalSender = signalSender
  }
  
  func kill(withID id: Int) {
    _ = signalSender.send(.kill, to: Int32(id))
  }
}
