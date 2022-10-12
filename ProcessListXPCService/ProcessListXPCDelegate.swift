//
//  ProcessListXPCServiceDelegate.swift
//  ProcessListXPCService
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation
import Libproc
import ProcessListToAppShared

final class ProcessListXPCDelegate: NSObject, NSXPCListenerDelegate {
  func listener(
    _ listener: NSXPCListener,
    shouldAcceptNewConnection newConnection: NSXPCConnection
  ) -> Bool {
    NSLog("XPCDebug: ProcessListXPCDelegate received new connection")
    configure(connection: newConnection)
    NSLog("XPCDebug: ProcessListXPCDelegate will accept new connection")
    return true
  }
  
  private func configure(connection: NSXPCConnection) {
    let errorHandlerProxy = ProcessListErrorHandlerProxy()
    connection.exportedInterface = NSXPCInterface(with: ProcessListXPC.self)
    connection.exportedObject = ProcessListXPCImpl(
      libProcWrapper: Libproc.wrapper,
      errorHandler: errorHandlerProxy
    )
    connection.remoteObjectInterface = NSXPCInterface(with: ProcessListHostProtocol.self)
    let hostObject = connection.remoteObjectProxyWithErrorHandler(errorHandlerProxy.handle) as? ProcessListHostProtocol
    errorHandlerProxy.subject = hostObject
    connection.resume()
  }
}
