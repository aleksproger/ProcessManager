//
//  Validators.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation
import ProcessManagerCore

public enum ConnectionValidators {
  public static func `default`(
    appBundleID: String,
    subjectCN: String,
    errorHandler: ErrorHandler
  ) -> ConnectionValidator {
    let contextFetcher = SecureContextFetcherImpl(errorHandler: errorHandler)
    
    let policy = CompositePolicy(policies: [
//      RequirementStringVerificationPolicy(appBundleID: appBundleID, subjectCN: subjectCN),
//      VulnerableEntitlementsVerificationPolicy(),
//      HardenedRuntimeVerificationPolicy(),
    ])
    
    return ConnectionValidatorImpl(
      contextFetcher: contextFetcher,
      policy: policy,
      errorHandler: errorHandler
    )
  }
}
