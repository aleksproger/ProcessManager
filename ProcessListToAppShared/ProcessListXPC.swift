//
//  ProcessListXPC.swift
//  ProcessListToAppShared
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation

@objc public protocol ProcessListXPC {
    func list(reply: @escaping ([ProcessModel]) -> Void)
}
