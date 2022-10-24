//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation

internal protocol KeyGen {
    func generate() -> String
}

internal class UUIDKeyGen: KeyGen {
    
    let uuidFactory: UUIDFactory
    
    internal init(uuid: UUIDFactory = UUID()) {
        self.uuidFactory = uuid
    }
    
    internal func generate() -> String {
        return self.uuidFactory.uuidString
    }
}
