//
//  main.swift
//  ProcessKillerXPC
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation
import ProcessKillerToAppShared

NSLog("XPCDebug: ProcessKillerXPC has strted")
let listener = NSXPCListener(machServiceName: Constants.processKillerMachName)
let delegate = ProcessKillerXPCDelegate()
listener.delegate = delegate
listener.resume()
RunLoop.main.run()
