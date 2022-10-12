//
//  RequirementStringVerificationPolicy.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

final class RequirementStringVerificationPolicy: ConnectionVerificationPolicy {
  private let appBundleID: String
  private let subjectCN: String
  
  init(
    appBundleID: String,
    subjectCN: String
  ) {
    self.appBundleID = appBundleID
    self.subjectCN = subjectCN
  }
  
  func shouldVerify(context: SecureContext) throws -> Bool {
    let requirementString = "anchor apple generic and identifier \"\(appBundleID)\" and certificate leaf[subject.CN] = \"\(subjectCN)\" and certificate 1[field.1.2.840.113635.100.6.2.1] /* exists */" as NSString
    
    var securityRequirement: SecRequirement? = nil
    let status = SecRequirementCreateWithString(requirementString as CFString, SecCSFlags(rawValue: 0), &securityRequirement)
    
    guard let securityRequirement = securityRequirement,
          status == errSecSuccess else {
      throw VerificationError.unableToGetRequirementString
    }
    
    let checkStatus = SecCodeCheckValidity(context.secureCode, SecCSFlags(rawValue: 0), securityRequirement)
    guard checkStatus == errSecSuccess else {
      return false
    }
    
    return true
  }
}
