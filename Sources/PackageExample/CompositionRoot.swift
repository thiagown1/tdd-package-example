//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 25/10/22.
//

import Foundation

class CompositionRoot {
    func compose(keyEncryptor: Encryptor = KeyEncryptor(),
                 stringReader: StringFileReader = StringReader()) -> Storage {
        
        let localFileManager = LocalFileManager(stringReader: stringReader)
        return EncryptedLocalFileManagerDecorator(encryptor: keyEncryptor, decoratee: localFileManager)
    }
}
