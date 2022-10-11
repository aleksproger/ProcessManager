//
//  LoggingXPCConnection.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

final class LoggingXPCConnection: XPCConnection {
  override var wrappedValue: NSXPCConnection { connection.wrappedValue }
  
  private let connection: XPCConnection
  
  init(connection: XPCConnection) {
    self.connection = connection
    
    super.init()
    
    wrappedValue.configure { connection in
      let objectDescription = String(describing: connection)
      connection.invalidationHandler = {
        NSLog("XPCDebug: Invalidation handler called for \(objectDescription) try to resume")
      }
      
      connection.interruptionHandler = {
        NSLog("XPCDebug: Interruption handler called for \(objectDescription)")
      }
    }
  }
  
  override func resume() { connection.resume() }
  
  override func getService<T>(of type: T.Type) -> Result<T, Error> { connection.getService(of: type) }
}
