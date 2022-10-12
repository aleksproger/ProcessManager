//
//  main.swift
//  ProcessKillerXPC
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation

NSLog("XPCDebug: ProcessKillerXPC has strted")
let listener = NSXPCListener(machServiceName: Constants.listenerMachName)
let delegate = ProcessKillerXPCDelegate()
listener.delegate = delegate
listener.resume()
RunLoop.main.run()
