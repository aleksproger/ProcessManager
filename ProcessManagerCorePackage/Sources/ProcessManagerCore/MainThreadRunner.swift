//
//  MainThreadRunner.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 12.10.2022.
//

import Foundation

public typealias MainThreadRunner = (@escaping () -> Void) -> Void

public func onMainThreadAsync(_ block: @escaping () -> Void) {
  DispatchQueue.main.async {
    block()
  }
}
