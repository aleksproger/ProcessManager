//
//  DefaultXPCConnection.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

final class DefaultXPCConnection: XPCConnection {
  enum Error: Swift.Error { case protocolCastingFailed }
  
  override var wrappedValue: NSXPCConnection { connection }
  
  private let connection: NSXPCConnection
  
  private var isStarted: Bool = false
  
  init(
    connection: NSXPCConnection,
    configurator: @escaping (inout NSXPCConnection) -> Void
  ) {
    connection.configure(block: configurator)
    self.connection = connection
    
    super.init()
  }
  
  override func resume() {
    guard !isStarted else {
      return NSLog("XPCDebug: Connection was already started")
    }
    isStarted = true
    connection.resume()
  }
  
  override func getService<T>(of type: T.Type) -> Result<T, Swift.Error> {
    guard let service = wrappedValue.remoteObjectProxyWithErrorHandler({ error in
      NSLog("XPCDebug: Received error on remote object \(error)")
    }) as? T else {
      return .failure(Error.protocolCastingFailed)
    }
    return .success(service)
  }
}

extension DefaultXPCConnection {
  func logging() -> LoggingXPCConnection {
    LoggingXPCConnection(connection: self)
  }
}
