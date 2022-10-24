//
//  LocalFileManagerTests.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//
@testable import PackageExample
import XCTest

class LocalFileManagerTests: XCTestCase {

    func test_init_doesNotInvokeAnything() {
        let (_, urlStubSpy, stringStubSpy) = makeSUT()
        
        XCTAssertTrue(urlStubSpy.messages.isEmpty)
        XCTAssertTrue(stringStubSpy.messages.isEmpty)
    }
    
    func test_read_readsFromPath() {
        
        let (sut, urlStubSpy, stringStubSpy) = makeSUT()
        
        urlStubSpy.stubbedUrls = [anyURL()]
        stringStubSpy.stubbedString = anyString()
        
        let result = try? sut.read()
        
        XCTAssert(result == anyString())
        XCTAssert(urlStubSpy.messages == [.urls(.documentDirectory,
                                                .userDomainMask)])
        XCTAssert(stringStubSpy.messages == [.from(anyURL(appending: "/Test"))])
    }
    
    func test_write_writesOnPath() {
        let (sut, urlStubSpy, stringStubSpy) = makeSUT()
        
        urlStubSpy.stubbedUrls = [anyURL()]
        
        try? sut.write(dataString: anyString())
        
        XCTAssert(urlStubSpy.messages == [.urls(.documentDirectory,
                                                .userDomainMask)])
        XCTAssert(stringStubSpy.messages == [.to(anyURL(appending: "/Test"), dataString: anyString())])
    }
    
    func test_read_EmptyUrls_throwsNoURLException() {
        let (sut, _, _) = makeSUT()
        
        do {
            _ = try sut.read()
            XCTFail("Expected Exception")
        } catch {
            if let customError = error as? LocalFileManager.Exceptions {
                XCTAssertEqual(customError, LocalFileManager.Exceptions.noURL)
            } else {
                XCTFail("Expected Custom Exception")
            }
        }
    }
    
    func test_write_EmptyUrls_throwsNoURLException() {
        
        
        expectNoURLExceptionWhen { [weak self] in
            guard let (sut, _, _) = self?.makeSUT() else {
                XCTFail()
                return
            }
            
            try sut.write(dataString: self?.anyString() ?? "")
        }
    }
    
    func expectNoURLExceptionWhen(_ completion: @escaping () throws -> Void) {
        do {
            try completion()
            XCTFail("Expected Exception")
        } catch {
            if let customError = error as? LocalFileManager.Exceptions {
                XCTAssertEqual(customError, LocalFileManager.Exceptions.noURL)
            } else {
                XCTFail("Expected Custom Exception")
            }
        }
    }
    
    // Multiple URLs chooses first
    func test_read_MultipleURLs_PicksFirst() {
        let (sut, urlStubSpy, stringStubSpy) = makeSUT(path: "Test")
        
        urlStubSpy.stubbedUrls = [anyURL(), anyOtherURL()]
        
        _ = try? sut.read()
        
        XCTAssert(urlStubSpy.messages == [.urls(.documentDirectory,
                                                .userDomainMask)])
        XCTAssert(stringStubSpy.messages == [.from(anyURL(appending: "/Test"))])
    }
    
    func test_write_MultipleURLs_PicksFirst() {
        let (sut, urlStubSpy, stringStubSpy) = makeSUT(path: "Test")
        
        urlStubSpy.stubbedUrls = [anyURL(), anyOtherURL()]
        
        try? sut.write(dataString: anyString())
        
        XCTAssert(urlStubSpy.messages == [.urls(.documentDirectory,
                                                .userDomainMask)])
        XCTAssert(stringStubSpy.messages == [.to(anyURL(appending: "/Test"), dataString: anyString())])
    }
 
    func makeSUT(path: String = "Test") -> (LocalFileManager, URLFactoryStubSpy, StringReaderStubSpy) {
        let urlFactoryStubSpy = URLFactoryStubSpy()
        let stringStubSpy = StringReaderStubSpy()
        let sut = LocalFileManager(localPath: path, urlFactory: urlFactoryStubSpy, stringReader: stringStubSpy)

        return (sut, urlFactoryStubSpy, stringStubSpy)
    }
    
    class URLFactoryStubSpy: URLFactory {
        
        enum MessageType: Equatable {
            case urls (_ directory: FileManager.SearchPathDirectory, _ domainMask: FileManager.SearchPathDomainMask)
        }
        
        var messages: [MessageType] = []
        
        internal var stubbedUrls: [URL]?
        
        func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
            
            messages.append(.urls(directory, domainMask))
            return stubbedUrls ?? []
        }
    }
    
    class StringReaderStubSpy: StringFileReader {
    
        enum MessageType: Equatable {
            case from (_ url: URL)
            case to (_ url: URL, dataString: String)
        }
        
        var messages: [MessageType] = []
        internal var stubbedString: String?
        
        func from(contentsOf url: URL, encoding enc: String.Encoding) -> String? {
            messages.append(.from(url))
            return stubbedString
        }
        
        func to(url: URL, stringData: StringData) {
            messages.append(.to(url, dataString: stringData as! String))
        }
    }
}
