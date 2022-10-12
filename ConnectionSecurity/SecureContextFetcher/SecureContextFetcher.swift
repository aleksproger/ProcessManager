//
//  SecureContextFetcher.swift
//  com.alex.ProcessKillerXPCService
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

protocol SecureContextFetcher {
  func fetchSecureContext(for connection: NSXPCConnection) -> Result<SecureContext, Error>
}
