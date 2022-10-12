//
//  XPCConnectionConfigurator.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import ProcessManagerCore
import Foundation
import ProcessListToAppShared
import ProcessKillerToAppShared

enum Connections {
  static func processKillerConnection(errorHandler: ErrorHandler) -> XPCConnection {
    let killerServiceConnection = NSXPCConnection(
      machServiceName: ProcessKillerToAppShared.Constants.processKillerMachName
    )
    return DefaultXPCConnection(connection: killerServiceConnection) { connection in
      connection.remoteObjectInterface = NSXPCInterface(with: ProcessKillerXPC.self)
      connection.exportedInterface = NSXPCInterface(with: ProcessKillerHostProtocol.self)
      connection.exportedObject = ProcessKillerHostProtocolImpl(errorHandler: errorHandler)
    }
    .logging()
  }
  
  
  static func processListConnection(
    errorHandler: ErrorHandler
  ) -> XPCConnection {
    let listServiceConnection = NSXPCConnection(
      serviceName: Constants.processListLabel
    )
    
    return DefaultXPCConnection(connection: listServiceConnection) { connection in
      let interface = NSXPCInterface(with: ProcessListXPC.self)
      var allowedClasses = interface.classes(
        for: #selector(ProcessListXPC.listAll(reply:)),
        argumentIndex: 0,
        ofReply: true
      )
      let customClasses = [ProcessModel.self].compactMap { $0 as AnyObject as? NSObject }
      customClasses.forEach { _ = allowedClasses.insert($0) }
      interface.setClasses(
        allowedClasses,
        for: #selector(ProcessListXPC.listAll(reply:)),
        argumentIndex: 0,
        ofReply: true
      )
      interface.setClasses(
        allowedClasses,
        for: #selector(ProcessListXPC.listUserOwned(reply:)),
        argumentIndex: 0,
        ofReply: true
      )
      
      connection.remoteObjectInterface = interface
      connection.exportedInterface = NSXPCInterface(with: ProcessKillerHostProtocol.self)
      connection.exportedObject = ProcessKillerHostProtocolImpl(errorHandler: errorHandler)
    }
    .logging()
  }
}
