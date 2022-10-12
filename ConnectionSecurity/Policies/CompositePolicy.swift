//
//  CompositePolicy.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

final class CompositePolicy: ConnectionVerificationPolicy {
  private let policies: [ConnectionVerificationPolicy]
  
  init(policies: [ConnectionVerificationPolicy]) {
    self.policies = policies
  }
  
  func shouldVerify(context: SecureContext) throws -> Bool {
    for policy in policies {
      guard try policy.shouldVerify(context: context) else {
        return false
      }
    }
    
    return true
  }
}
