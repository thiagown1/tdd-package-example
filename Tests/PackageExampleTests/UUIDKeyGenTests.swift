//
//  UUIDKeyGen.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import PackageExample
import XCTest


class UUIDKeyGenTests: XCTestCase {
    
    func test_init_doenNotInvokeAnything() {
        let (_, spy) = makeSUT()
        
        XCTAssertTrue(spy.messages.isEmpty)
    }
    
    func test_generate_deliversDependencyKey() {
        let (sut, stubSpy) = makeSUT()
        
        let uuid = anyString()
        stubSpy.stubbedString = uuid
        
        XCTAssertEqual(sut.generate(), uuid)
    }
    

    func makeSUT() -> (UUIDKeyGen, UUIDStubSpy) {
        let uuidFactory = UUIDStubSpy()
        let sut = UUIDKeyGen(uuid: uuidFactory)
        
        return (sut, uuidFactory)
    }
    
    class UUIDStubSpy: UUIDFactory {
        
        enum MessageType {
            case requestedUUID
        }
        
        var messages: [MessageType] = []
        
        var uuidString: String {
            get {
                messages.append(.requestedUUID)
                return self.stubbedString ?? ""
            }
        }
        
        var stubbedString: String?
    }
}
