//
//  SecureContextFetcherImpl.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation
import ProcessManagerCore

final class SecureContextFetcherImpl: SecureContextFetcher {
  private let errorHandler: ErrorHandler
  
  init(errorHandler: ErrorHandler) {
    self.errorHandler = errorHandler
  }
  
  func fetchSecureContext(for connection: NSXPCConnection) -> Result<SecureContext, Error> {
    let auditToken = AuditToken.getFrom(connection)
    
    let attributesDictrionary = [
        kSecGuestAttributeAudit : auditToken
    ]
    
    var secCode: SecCode? = nil
    let secCodeStatus = SecCodeCopyGuestWithAttributes(nil, attributesDictrionary as CFDictionary, SecCSFlags(rawValue: 0), &secCode)
    
    guard let secCode = secCode,
          secCodeStatus == errSecSuccess else {
      return .failure(FetchError.unableToGetSecCode)
    }
    
    var secCodeStatic: SecStaticCode? = nil
    let secCodeStaticStatus = SecCodeCopyStaticCode(secCode, SecCSFlags(rawValue: 0), &secCodeStatic)
    
  
    guard let secCodeStatic = secCodeStatic,
          secCodeStaticStatus == errSecSuccess else {
      return .failure(FetchError.unableToGetSecStaticCode)
    }
    
    let context = SecureContext(secureCode: secCode, secureStaticCode: secCodeStatic)
    return .success(context)

  }
}

private enum FetchError: Error {
  case unableToGetSecCode
  case unableToGetSecStaticCode
}
