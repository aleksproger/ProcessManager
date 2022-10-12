//
//  ProcessListHostProtocol.swift
//  ProcessListToAppShared
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation

import Foundation

@objc(ProcessListHostProtocol) public protocol ProcessListHostProtocol {
  func onError(withError: Error)
}
