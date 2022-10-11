//
//  ProcessKillerXPCImpl.swift
//  com.alex.ProcessKIllerXPC
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation
import SignalSender
import Libproc

final class ProcessKillerXPCImpl: ProcessKillerXPC {
    private let signalSender: SignalSender
    
    init(signalSender: SignalSender) {
        self.signalSender = signalSender
    }

    func kill(withID id: Int) {
        signalSender.send(.kill, to: Int32(id))
    }
}
