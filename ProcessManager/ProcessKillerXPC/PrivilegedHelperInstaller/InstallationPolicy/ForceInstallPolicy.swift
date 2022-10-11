//
//  ForceInstallPolicy.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

final class ForceInstallPolicy: InstallationPolicy {
    func shouldInstall(label: String) -> Bool { true }
}
