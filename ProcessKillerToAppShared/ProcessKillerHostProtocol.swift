//
//  ApplicationProtocol.swift
//  ProcessKillerToAppShared
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation

@objc(ProcessKillerHostProtocol) public protocol ProcessKillerHostProtocol {
  func onError(withError: Error)
}
