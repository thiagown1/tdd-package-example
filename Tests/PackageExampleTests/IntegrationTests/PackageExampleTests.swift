//
//  PackageExampleTests.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import XCTest
@testable import PackageExample

class PackageExampleTests: XCTestCase {
    
    func test_init_doesNotInvokerAnything() {
        let (_, stringReaderStubSpy) = makeSUT()
        
        XCTAssertEqual(stringReaderStubSpy.messages, [])
    }
    
    func test_configure_storesKeyGivenEmptyStorage() {
        let (sut, stringReaderStubSpy) = makeSUT()
        
        sut.configure()
        
        XCTAssertEqual(stringReaderStubSpy.messages, [.from, .to])
    }
    
    func test_configure_storesKeyGivenNotEmptyStorage() {
        let (sut, stringReaderStubSpy) = makeSUT()
        stringReaderStubSpy.stubbedString = anyString()
        
        sut.configure()
        
        XCTAssertEqual(stringReaderStubSpy.messages, [.from])
    }
    
    

    func makeSUT() -> (PackageExample, StringReaderStubSpy) {
        let stringReaderStubSpy = StringReaderStubSpy()
        let localFileManager = LocalFileManager(stringReader: stringReaderStubSpy)
        let sut = PackageExample(keyGen: UUIDKeyGen(), storage: localFileManager)
        
        return (sut, stringReaderStubSpy)
    }
    
    class StringReaderStubSpy: StringFileReader {
        
        var stubbedString: String?
        
        enum MessageType {
            case from
            case to
        }
        
        var messages: [MessageType] = []
        
        func from(contentsOf url: URL, encoding enc: String.Encoding) -> String? {
            messages.append(.from)
            return self.stubbedString
        }
        
        func to(url: URL, stringData: StringData) {
            messages.append(.to)
        }
    }
}
