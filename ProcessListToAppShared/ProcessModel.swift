//
//  ProcessInfo.swift
//  ProcessListToAppShared
//
//  Created by Aleksei Sapitskii on 9.10.2022.
//

import Foundation

public final class ProcessModel: NSObject {
        
    public let name: String
    public let id: Int
    
    public init(
        name: String,
        id: Int
    ) {
        self.name = name
        self.id = id
    }
}

extension ProcessModel: NSSecureCoding {
    public static var supportsSecureCoding: Bool { true }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(id, forKey: "id")
    }
    
    public convenience init?(coder: NSCoder) {
        guard
            let name = coder.decodeObject(of: NSString.self, forKey: "name") as? String,
            let id = coder.decodeObject(of: NSNumber.self, forKey: "id") as? Int
        else {
            return nil
        }
        
        self.init(name: name, id: id)
    }
}
