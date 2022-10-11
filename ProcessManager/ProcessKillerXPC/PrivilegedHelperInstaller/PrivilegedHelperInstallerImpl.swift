import Foundation
import ServiceManagement

final class PriviliegedHelperInstallerImpl: PriviliegedHelperInstaller {
    init() {}
    
    func install(label: String) throws {
        var cfError: Unmanaged<CFError>?
        
       try withAuthReference(block: { authReference in
            SMJobBless(
                kSMDomainSystemLaunchd,
                label as CFString,
                authReference,
                &cfError
            )
        })
        
        if let error = cfError {
            throw PrivelegedHelperAuthorizationError.smJobBlessFailed(
                error.takeRetainedValue().localizedDescription
            )
        }
    }
}

extension PriviliegedHelperInstallerImpl {
    private func withAuthItem(block: (inout AuthorizationItem) throws -> Void) throws {
      try kSMRightBlessPrivilegedHelper.withCString { authKey in
            var authItem = AuthorizationItem(
                name: authKey,
                valueLength: 0,
                value: UnsafeMutableRawPointer(bitPattern: 0),
                flags: 0
            )
            try block(&authItem)
        }
    }
    
    private func withAuthRights(block: (inout AuthorizationRights) throws -> Void) throws {
        try withAuthItem { authItem in
            try withUnsafeMutablePointer(to: &authItem) { authItem in
                var authRights = AuthorizationRights(count: 1, items: authItem)
                try block(&authRights)
            }
        }
    }
    
    private func withAuthReference(block: (AuthorizationRef) -> Void) throws {
        try withAuthRights { authRights in
            let authReference = try authorizationReference(
                &authRights,
                nil,
                [.interactionAllowed, .extendRights, .preAuthorize]
            )
            block(authReference)
        }
    }

    private func authorizationReference(
        _ rights: UnsafePointer<AuthorizationRights>?,
        _ environment: UnsafePointer<AuthorizationEnvironment>?,
        _ flags: AuthorizationFlags
    ) throws -> AuthorizationRef {
        var authorizationReference: AuthorizationRef?
        try executeAuthorizationFunction { AuthorizationCreate(rights, environment, flags, &authorizationReference) }
        
        guard let authorizationReference = authorizationReference else {
            throw PrivelegedHelperAuthorizationError.unableToCreateAuthReference
        }
        
        return authorizationReference
    }

    private func executeAuthorizationFunction(_ authorizationFunction: () -> (OSStatus) ) throws {
        let osStatus = authorizationFunction()
        guard osStatus == errAuthorizationSuccess else {
            throw PrivelegedHelperAuthorizationError.unsuccesfulOSStatus(
                String(describing: SecCopyErrorMessageString(osStatus, nil))
            )
        }
    }
}
