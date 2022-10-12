//
//  VerificationError.swift
//  ConnectionSecurity
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation

public enum VerificationError: String, Error {
  case unableToGetSigningInformation
  case unableToGetEntitlements
  case vulnerableEntitlementUsed
  case hardenedRuntimeFlagMissing
  case requirementStringInvalid
  case unableToGetRequirementString
}
