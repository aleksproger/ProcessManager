//
//  main.swift
//  ProcessListXPCService
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation

let listener = NSXPCListener.service()
let serviceDelegate = ProcessListXPCDelegate()
listener.delegate = serviceDelegate
NSLog("XPCDebug: ProcessListXPC is running")
listener.resume()

