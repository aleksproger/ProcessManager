//
//  VulnerableEntitlements.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

enum VulnerableEntitlements: String, CaseIterable {
  case getTask = "com.apple.security.get-task-allow"
  case libraryValidation = "com.apple.security.cs.disable-library-validation"
  case dyldVariables = "com.apple.security.cs.allow-dyld-environment-variables"
}
