//
//  InstallableProcessKiller.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation
import ProcessManagerCore
import ProcessKillerToAppShared

final class DefaultErrorHandlingProcessKiller: ErrorHandlingProcessKiller {
  enum ProcessKillerError: Error { case unableToKillProcess(Int) }
  
  private let installer: PriviliegedHelperInstaller
  private let errorHandler: ErrorHandler
  private let connection: XPCConnection
  
  init(
    installer: PriviliegedHelperInstaller,
    errorHandler: ErrorHandler,
    connection: XPCConnection
  ) {
    self.installer = installer
    self.errorHandler = errorHandler
    self.connection = connection
  }
  
  func kill(withID: Int) {
    do {
      try installer.install(label: ProcessKillerToAppShared.Constants.processKillerMachName)
      connection.resume()
      let service = try connection.getService(of: ProcessKillerXPC.self).get()
      service.kill(withID: withID)
    } catch {
      errorHandler.handle(error)
    }
  }
}
