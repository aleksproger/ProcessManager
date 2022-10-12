//
//  LoggingXPCConnection.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

public final class LoggingXPCConnection: XPCConnection {
  public override var wrappedValue: NSXPCConnection { connection.wrappedValue }
  
  private let connection: XPCConnection
  
  public init(
    connection: XPCConnection
  ) {
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
  
  public override func resume() { connection.resume() }
  
  public override func getService<T>(of type: T.Type) -> Result<T, Error> { connection.getService(of: type) }
}
