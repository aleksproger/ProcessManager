//
//  XPCConnection.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

public class XPCConnection {
  public var wrappedValue: NSXPCConnection { fatalError("Abstract class implementation") }
  public func resume() { fatalError("Abstract class implementation") }
  public func getService<T>(of type: T.Type) -> Result<T, Error> { fatalError("Abstract class implementation") }
}
