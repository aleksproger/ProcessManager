//
//  VulnerableEntitlementaVerificationPolicy.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

final class VulnerableEntitlementsVerificationPolicy: ConnectionVerificationPolicy {
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
    
    guard let maybeEntitlementsDict = (signingInformation as NSDictionary).object(forKey: "entitlements-dict"),
          let entitlementsDict = maybeEntitlementsDict as? NSDictionary else {
      throw VerificationError.unableToGetEntitlements
    }
    
    
    for entitlementsKey in VulnerableEntitlements.allCases {
      guard let entitlement = entitlementsDict.object(forKey: entitlementsKey),
            let entitlementValue = entitlement as? Int,
            entitlementValue != 1
      else {
        throw VerificationError.vulnerableEntitlementUsed
      }
    }
    
    return true
  }
}

