//
//  ServiceDelegate.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation
import SignalSender
import ProcessKillerToAppShared
import ProcessManagerCore
import ConnectionSecurity

final class ProcessKillerXPCDelegate: NSObject, NSXPCListenerDelegate {
  func listener(
    _ listener: NSXPCListener,
    shouldAcceptNewConnection newConnection: NSXPCConnection
  ) -> Bool {
    NSLog("XPCDebug: ProcessKillerXPC received new connection")
    guard isValid(connection: newConnection) else {
      return false
    }
    NSLog("XPCDebug: ProcessKillerXPC will accept new connection")

    configure(connection: newConnection)
    
    return true
  }
  
  private func isValid(connection: NSXPCConnection) -> Bool {
    NSLog("XPCDebug: ProcessKillerXPC will validate new connection")
    let validator = ConnectionValidators.default(
      appBundleID: Constants.appBundle,
      subjectCN: Constants.subjectCN,
      errorHandler: LoggingErrorHandler(subject: DefaultErrorHandler())
    )
    guard validator.isValid(connection: connection) else {
      NSLog("XPCDebug: ProcessKillerXPC refuses new connection")
      return false
    }
    
    return true
  }
  
  private func configure(connection: NSXPCConnection) {
    let errorHandlerProxy = ProcessKillerErrorHandlerProxy()
    let exportedObject = ProcessKillerXPCImpl(
      signalSender: SignalSenderImpl(),
      errorHandler: errorHandlerProxy
    )
    connection.exportedInterface = NSXPCInterface(with: ProcessKillerXPC.self)
    connection.exportedObject = exportedObject
    connection.remoteObjectInterface = NSXPCInterface(with: ProcessKillerHostProtocol.self)
    let hostObject = connection.remoteObjectProxyWithErrorHandler(errorHandlerProxy.handle) as? ProcessKillerHostProtocol
    errorHandlerProxy.subject = hostObject
    connection.resume()
  }
}
