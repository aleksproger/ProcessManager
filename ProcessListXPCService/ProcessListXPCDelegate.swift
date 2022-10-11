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
        newConnection.exportedInterface = NSXPCInterface(with: ProcessListXPC.self)
        newConnection.exportedObject = ProcessListXPCImpl(libProcWrapper: Libproc.wrapper)
        newConnection.resume()
        NSLog("XPCDebug: ProcessListXPCDelegate will accept new connection")
        return true
    }
}
