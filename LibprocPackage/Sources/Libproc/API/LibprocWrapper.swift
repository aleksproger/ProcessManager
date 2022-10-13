//
//  LibProcWrapper.swift
//  libprocBridge
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation

public protocol LibprocWrapper {
  func allPids() -> Result<[Int], Error>
  func userPids() -> Result<[Int], Error>
  func name(for pid: Int) -> Result<String, Error>
}
