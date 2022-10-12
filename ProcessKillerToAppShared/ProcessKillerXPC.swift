//
//  ProcessKillerXPC.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

@objc(ProcessKillerXPC) public protocol ProcessKillerXPC {
  func kill(withID: Int, reply: @escaping (Bool) -> Void)
}
