//
//  ProcessKilerXPC.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

@objc(ProcessKillerXPC) protocol ProcessKillerXPC {
  func kill(withID: Int)
}
