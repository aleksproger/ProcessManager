//
//  HardenedRuntimeVerificationPolicy.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

final class HardenedRuntimeVerificationPolicy: ConnectionVerificationPolicy {
  private let hardenedRuntimeFlag: UInt32 = 0x10000
  
  func shouldVerify(context: SecureContext) throws -> Bool {
    var signingInformation: CFDictionary? = nil
    
    let status = SecCodeCopySigningInformation(
      context.secureStaticCode,
      SecCSFlags(rawValue: kSecCSDynamicInformation),
      &signingInformation
    )
    
    guard status == errSecSuccess,
          let signingInformation = signingInformation
    else {
      throw VerificationError.unableToGetSigningInformation
    }
    
    guard let flags = (signingInformation as NSDictionary).object(forKey: "flags") as? UInt32,
          (flags & hardenedRuntimeFlag) == hardenedRuntimeFlag else {
      throw VerificationError.hardenedRuntimeFlagMissing
    }
    
    return true
  }
}
