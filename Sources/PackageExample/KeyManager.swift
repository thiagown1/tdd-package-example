//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation

internal class KeyManager {
    private let keyGen: KeyGen
    private let fileManager: Storage
    
    internal init(keyGen: KeyGen = UUIDKeyGen(), fileManager: Storage = LocalFileManager()) {
        self.keyGen = keyGen
        self.fileManager = fileManager
    }
    
    internal func writeIfNeeded() -> String {
    
        guard let data = try? fileManager.read() else {
            let key = self.keyGen.generate()
            try? fileManager.write(dataString: key)
            return key
        }
        
        return data
    }
}
