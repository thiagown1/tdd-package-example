//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation

public protocol KeyGen {
    func generate() -> String
}

public class UUIDKeyGen: KeyGen {
    
    let uuidFactory: UUIDFactory
    
    public init(uuid: UUIDFactory = UUID()) {
        self.uuidFactory = uuid
    }
    
    public func generate() -> String {
        return self.uuidFactory.uuidString
    }
}
