//
//  ServiceDelegate.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation
import SignalSender

final class ProcessKillerXPCDelegate: NSObject, NSXPCListenerDelegate {
  func listener(
    _ listener: NSXPCListener,
    shouldAcceptNewConnection newConnection: NSXPCConnection
  ) -> Bool {
    NSLog("XPCDebug: ProcessKillerXPC received new connection")
    let exportedObject = ProcessKillerXPCImpl(signalSender: SignalSenderImpl())
    newConnection.exportedInterface = NSXPCInterface(with: ProcessKillerXPC.self)
    newConnection.exportedObject = exportedObject
    newConnection.resume()
    NSLog("XPCDebug: ProcessKillerXPC will accept new connection")
    return true
  }
}
