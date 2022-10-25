//
//  KeyEncryptor.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 25/10/22.
//

import XCTest
@testable import PackageExample
import CryptoKit

class KeyEncryptorTests: XCTestCase {
    
    func test_encrypt_doesReturnEncryptedString() {
        let sut = makeSUT()
        let anyString = anyString()
        
        let encryptedString = sut.encrypt(anyString)
        
        XCTAssertNotEqual(anyString, encryptedString)
    }
    
    func test_encrypt_decrypt_deliversOriginalString() {
        let sut = makeSUT()
        let anyString = anyString()
        
        let encryptedString = sut.encrypt(anyString)!
        let decryptedString = sut.decrypt(encryptedString)
        
        XCTAssertEqual(anyString, decryptedString)
    }

    func makeSUT() -> KeyEncryptor {
        let sut = KeyEncryptor()
        
        return sut
    }

}
