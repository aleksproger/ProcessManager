//
//  XPCConnection.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

class XPCConnection {
    var wrappedValue: NSXPCConnection { fatalError("Abstract class implementation") }
    func resume() { fatalError("Abstract class implementation") }
    func getService<T>(of type: T.Type) -> Result<T, Error> { fatalError("Abstract class implementation") }
}
