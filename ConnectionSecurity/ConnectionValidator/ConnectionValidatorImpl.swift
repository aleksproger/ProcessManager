//
//  ConnectionValidatorImpl.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation
import ProcessManagerCore

final class ConnectionValidatorImpl: ConnectionValidator {
  private let contextFetcher: SecureContextFetcher
  private let policy: ConnectionVerificationPolicy
  private let errorHandler: ErrorHandler
  
  init(
    contextFetcher: SecureContextFetcher,
    policy: ConnectionVerificationPolicy,
    errorHandler: ErrorHandler
  ) {
    self.contextFetcher = contextFetcher
    self.policy = policy
    self.errorHandler = errorHandler
  }
  
  func isValid(connection: NSXPCConnection) -> Bool {
    do {
      let secureContext = try contextFetcher.fetchSecureContext(for: connection).get()
      return try policy.shouldVerify(context: secureContext)
    } catch {
      errorHandler.handle(error)
      return true
    }
  }
}
