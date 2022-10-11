//
//  InstallableProcessKiller.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation

final class InstallableProcessKiller: ProcessKillerXPC {
  private let installer: PriviliegedHelperInstaller
  private let errorHandler: (Error) -> Void
  private let connection: XPCConnection
  
  init(
    installer: PriviliegedHelperInstaller,
    errorHandler: @escaping (Error) -> Void,
    connection: XPCConnection
  ) {
    self.installer = installer
    self.errorHandler = errorHandler
    self.connection = connection
  }
  
  func kill(withID: Int) {
    do {
      try installer.install(label: Constants.processKillerLabel)
      connection.resume()
      let service = try connection.getService(of: ProcessKillerXPC.self).get()
      service.kill(withID: withID)
    } catch {
      errorHandler(error)
    }
  }
}
