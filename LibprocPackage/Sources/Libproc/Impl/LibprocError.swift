//
//  LibProcError.swift
//  libprocBridge
//
//  Created by Aleksei Sapitskii on 6.10.2022.
//

import Foundation

enum LibprocError: Error {
    case incorrectBuffer(size: Int32)
}
