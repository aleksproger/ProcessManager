//
//  ProcessManagerXPCServiceImpl.swift
//  ProcessListXPCService
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation
import Libproc
import ProcessListToAppShared
import ProcessManagerCore

final class ProcessListXPCImpl: ProcessListXPC {
  private let libprocWrapper: LibprocWrapper
  private let errorHandler: ErrorHandler
  
  init(
    libProcWrapper: LibprocWrapper,
    errorHandler: ErrorHandler
  ) {
    self.libprocWrapper = libProcWrapper
    self.errorHandler = errorHandler
  }
  
  func listAll(
    reply: ([ProcessModel]) -> Void
  ) {
    list(.all, reply: reply)
  }
  
  func listUserOwned(reply: @escaping ([ProcessModel]) -> Void) {
    list(.userOwned, reply: reply)
  }
  
  private func list(
    _ type: ProcessListType,
    reply: ([ProcessModel]) -> Void
  ) {
    do {
      let processModels: [ProcessModel] = try getProcessIDs(type).map { id in
        let name = try? libprocWrapper.name(for: id).get()
        return ProcessModel(name: name ?? "<Root Owned>", id: id)
      }
      reply(processModels)
    } catch {
      errorHandler.handle(error)
    }
  }
  
  private func getProcessIDs(_ type: ProcessListType) throws -> [Int] {
    switch type {
      case .userOwned:
        return try libprocWrapper.userPids().get()
      case .all:
        return try libprocWrapper.allPids().get()
    }
  }
}
