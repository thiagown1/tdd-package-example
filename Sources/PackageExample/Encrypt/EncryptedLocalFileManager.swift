//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 25/10/22.
//

import Foundation

internal class EncryptedLocalFileManagerDecorator: Storage {
    
    private let encryptor: Encryptor
    private let decoratee: LocalFileManager?
    
    internal enum CryptError: Error {
        case encrypt
        case decrypt
    }
    
    internal init(encryptor: Encryptor, decoratee: LocalFileManager) {
        self.encryptor = encryptor
        self.decoratee = decoratee
    }
    
    internal func write(dataString: String) throws {
        guard let encryptedString = self.encryptor.encrypt(dataString) else {
            throw CryptError.encrypt
        }
        
        try self.decoratee?.write(dataString: encryptedString)
    }
    
    internal func read() throws -> String? {
        guard let data = try self.decoratee?.read() else {
            return nil
        }
        
        guard let decryptedString = self.encryptor.decrypt(data) else {
            throw CryptError.decrypt
        }
        
        return decryptedString
    }
}

