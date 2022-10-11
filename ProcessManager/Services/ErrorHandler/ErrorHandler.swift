//
//  ErrorHandler.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation

protocol ErrorHandler {
  func handle(_ error: Error)
}
