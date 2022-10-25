//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 25/10/22.
//

import Foundation
import CryptoKit


internal class KeyEncryptor: Encryptor {
    
    private let key = SymmetricKey(data: "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw".data(using: .utf8)!)
    
    internal func encrypt(_ dataString: String) -> String? {
        let data = dataString.data(using: .utf8)!
        
        
        if let encryptedData = try? ChaChaPoly.seal(data, using: key) {
            return encryptedData.combined.base64EncodedString()
        }
        
        return nil
    }
    
    internal func decrypt(_ dataString: String) -> String? {
        
        guard let data = Data(base64Encoded: dataString) else {
            return nil
        }
        
        let sealedBox = try! ChaChaPoly.SealedBox(combined: data)
        guard let decryptedData = try? ChaChaPoly.open(sealedBox, using: key) else {
            return nil
        }
        
        return String(data: decryptedData, encoding: .utf8)
    }
}

