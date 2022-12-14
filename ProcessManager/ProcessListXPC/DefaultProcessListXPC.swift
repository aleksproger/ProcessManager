//
//  DefaultProcessListXPC.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation
import ProcessListToAppShared
import ProcessManagerCore

final class DefaultProcessListXPC: ProcessListXPC {
  private let connection: XPCConnection
  private let errorHandler: (Error) -> Void
  
  init(
    connection: XPCConnection,
    errorHandler: @escaping (Error) -> Void
  ) {
    self.connection = connection
    self.errorHandler = errorHandler
  }
  
  func listAll(reply: @escaping ([ProcessModel]) -> Void) {
    do {
      connection.resume()
      let service = try connection.getService(of: ProcessListXPC.self).get()
      service.listAll(reply: reply)
    } catch {
      errorHandler(error)
    }
  }
  
  func listUserOwned(reply: @escaping ([ProcessModel]) -> Void) {
    do {
      connection.resume()
      let service = try connection.getService(of: ProcessListXPC.self).get()
      service.listUserOwned(reply: reply)
    } catch {
      errorHandler(error)
    }
  }
}
