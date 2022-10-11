//
//  XPCConnectionConfigurator.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation
import ProcessListToAppShared

enum Connections {
   static let processKillerConnection: XPCConnection = {
        let killerServiceConnection = NSXPCConnection(
            machServiceName: Constants.processKillerLabel,
            options: .privileged
        )
        return DefaultXPCConnection(connection: killerServiceConnection) { connection in
           connection.remoteObjectInterface = NSXPCInterface(with: ProcessKillerXPC.self)
        }
        .logging()
    }()
    
    static let processListConnection: XPCConnection = {
        let listServiceConnection = NSXPCConnection(serviceName: Constants.processListLabel)
     
        return DefaultXPCConnection(connection: listServiceConnection) { connection in
            let interface = NSXPCInterface(with: ProcessListXPC.self)
            var allowedClasses = interface.classes(
                for: #selector(ProcessListXPC.list(reply:)),
                argumentIndex: 0,
                ofReply: true
            )
            let customClasses = [ProcessModel.self].compactMap { $0 as AnyObject as? NSObject }
            customClasses.forEach { _ = allowedClasses.insert($0) }
            interface.setClasses(
                allowedClasses,
                for: #selector(ProcessListXPC.list(reply:)),
                argumentIndex: 0,
                ofReply: true
            )
            connection.remoteObjectInterface = interface
        }
        .logging()
    }()
}
