//
//  InstallationPolicy.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

protocol InstallationPolicy {
    func shouldInstall(label: String) -> Bool
}
