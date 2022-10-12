//
//  KillError.swift
//  ProcessKillerToAppShared
//
//  Created by Aleksei Sapitskii on 13.10.2022.
//

import Foundation

public enum KillError: Error {
  case unableToKillProcess
  
  var localizedDescription: String {
    "Unable to kill process. Try again."
  }
}
