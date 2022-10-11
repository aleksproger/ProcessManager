//
//  PolicyRegulatedInstaller.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 10.10.2022.
//

import Foundation

final class PolicyRegulatedInstaller: PriviliegedHelperInstaller {
    private let installationPolicy: InstallationPolicy
    private let subject: PriviliegedHelperInstaller
    
    init(
        installationPolicy: InstallationPolicy,
        subject: PriviliegedHelperInstaller
        
    ) {
        self.installationPolicy = installationPolicy
        self.subject = subject
    }
    
    func install(label: String) throws {
        guard installationPolicy.shouldInstall(label: label) else {
            return
        }
        
        try subject.install(label: label)
    }
}
