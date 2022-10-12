//
//  FileManagerTwin.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

public protocol FileManagerTwin {
    func fileExists(atPath: String) -> Bool
}

extension FileManager: FileManagerTwin {}
