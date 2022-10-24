//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation

public class KeyManager {
    private let keyGen: KeyGen
    private let fileManager: Storage
    
    public init(keyGen: KeyGen = UUIDKeyGen(), fileManager: Storage = LocalFileManager()) {
        self.keyGen = keyGen
        self.fileManager = fileManager
    }
    
    public func writeIfNeeded() -> String {
    
        guard let data = try? fileManager.read() else {
            let key = self.keyGen.generate()
            try? fileManager.write(dataString: key)
            return key
        }
        
        return data
    }
}
