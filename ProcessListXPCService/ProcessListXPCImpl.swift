//
//  ProcessManagerXPCServiceImpl.swift
//  ProcessListXPCService
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation
import Libproc
import ProcessListToAppShared

final class ProcessListXPCImpl: ProcessListXPC {
  private let libprocWrapper: LibprocWrapper
  
  init(libProcWrapper: LibprocWrapper) {
    self.libprocWrapper = libProcWrapper
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
      reply([])
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
