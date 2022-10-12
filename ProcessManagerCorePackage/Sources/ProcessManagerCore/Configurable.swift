//
//  Configurable.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

public protocol Configurable {}

extension Configurable {
    @discardableResult
    public func configure(block: @escaping (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension NSObject: Configurable {}
