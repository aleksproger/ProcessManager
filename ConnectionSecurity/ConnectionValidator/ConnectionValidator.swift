//
//  ConnectionValidator.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

public protocol ConnectionValidator {
  func isValid(connection: NSXPCConnection) -> Bool
}
