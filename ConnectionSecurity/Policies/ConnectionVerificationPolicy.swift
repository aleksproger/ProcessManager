//
//  ConnectionVerificationPolicy.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

protocol ConnectionVerificationPolicy {
  func shouldVerify(context: SecureContext) throws -> Bool
}
