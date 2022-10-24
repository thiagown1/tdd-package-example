//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import PackageExample
import XCTest

class KeyManagerTests: XCTestCase {
    
    func test_init_doesNotInvokeAnything( ) {
        let (_, keyGenStubSpy, fileManagerStubSpy) = makeSUT()
        
        XCTAssertTrue(keyGenStubSpy.messages.isEmpty)
        XCTAssertTrue(fileManagerStubSpy.messages.isEmpty)
    }
    
    func test_write_generateKeyOnFirstCall( ) {
        let (sut, keyGenStubSpy, fileManagerStubSpy) = makeSUT()
        let uuid = anyString()
        
        keyGenStubSpy.stubbedString = uuid
        
        let result = sut.writeIfNeeded()
        
        XCTAssertEqual(result, uuid)
        XCTAssertEqual(keyGenStubSpy.messages, [.generate])
        XCTAssertEqual(fileManagerStubSpy.messages, [.read, .write])
    }
    
    func test_write_readKeyOnSecondCall( ) {
        let (sut, keyGenStubSpy, fileManagerStubSpy) = makeSUT()
        let uuid = anyString()
        
        keyGenStubSpy.stubbedString = uuid
        
        let result = sut.writeIfNeeded()
        
        XCTAssertEqual(result, uuid)
        XCTAssertEqual(keyGenStubSpy.messages, [.generate])
        XCTAssertEqual(fileManagerStubSpy.messages, [.read, .write])
        
        fileManagerStubSpy.stubbedString = uuid
        
        let secondResult = sut.writeIfNeeded()
        
        XCTAssertEqual(secondResult, uuid)
        XCTAssertEqual(keyGenStubSpy.messages, [.generate])
        XCTAssertEqual(fileManagerStubSpy.messages, [.read, .write, .read])
    }
    
    func makeSUT() -> (KeyManager, KeyGenStubSpy, FileManagerStubSpy) {
        let keyGenStubSpy = KeyGenStubSpy()
        let fileManagerStubSpy = FileManagerStubSpy()
        let sut = KeyManager(keyGen: keyGenStubSpy, fileManager: fileManagerStubSpy)
        
        return (sut, keyGenStubSpy, fileManagerStubSpy)
    }
    
    class KeyGenStubSpy: KeyGen {
        
        var stubbedString: String?
        
        enum MessageType {
            case generate
        }
        
        var messages: [MessageType] = []
        
        func generate() -> String {
            messages.append(.generate)
            return self.stubbedString ?? ""
        }
    }
    
    class FileManagerStubSpy: Storage {
        
        var stubbedString: String?
        
        enum MessageType {
            case read
            case write
        }
        
        var messages: [MessageType] = []
        
        func read() throws -> String? {
            messages.append(.read)
            return stubbedString
        }
        
        func write(dataString: String) throws {
            messages.append(.write)
        }
    }
}
