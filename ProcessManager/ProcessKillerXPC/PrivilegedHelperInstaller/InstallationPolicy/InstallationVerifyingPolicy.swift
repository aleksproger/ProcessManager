//
//  InstallationVerifyingPolicy.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation
import ProcessManagerCore

final class InstallationVerifyingPolicy: InstallationPolicy {
    private let fileManager: FileManagerTwin
    
    init(fileManager: FileManagerTwin) {
        self.fileManager = fileManager
    }
    
    func shouldInstall(label: String) -> Bool {
        !fileManager.fileExists(atPath: "\(Constants.priveledHelpersDirectory)\(label)")
    }
}
