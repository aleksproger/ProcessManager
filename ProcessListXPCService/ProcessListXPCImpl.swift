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
    
    func list(
        reply: ([ProcessModel]) -> Void
    ) {
        do {
            let processIDs = try libprocWrapper.pids().get()
            let processModels: [ProcessModel] = processIDs.map { id in
                let name = try? libprocWrapper.name(for: id).get()
                return ProcessModel(name: name ?? "<Root Owned>", id: id)
            }
            reply(processModels)
        } catch {
            reply([])
        }
    }
}

