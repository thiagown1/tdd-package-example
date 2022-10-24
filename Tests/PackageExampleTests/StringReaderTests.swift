//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import PackageExample
import XCTest

class StringReaderTests: XCTestCase {
    
    func test_to_invokeDataAndWrites() {
        let sut = makeSUT()

        let stringData = StringDataStubSpy()
        let dataWriter = DataWriterStubSpy()

        let url = anyURL()
        
        
        stringData.stubbedData = dataWriter
        
        sut.to(url: url, stringData: stringData)

        XCTAssertEqual(stringData.messages, [.data])
        XCTAssertEqual(dataWriter.messages, [.write])
    }
    
    func makeSUT() -> StringReader {
        let sut = StringReader()
        
        return sut
    }
    
    class StringDataStubSpy: StringData {
        
        var stubbedData: DataWriter?
        
        enum MessageType {
            case data
        }
        
        var messages: [MessageType] = []
        
        func dataWritter(using encoding: String.Encoding, allowLossyConversion: Bool) -> DataWriter? {
            messages.append(.data)
            return stubbedData
        }
    }
    
    class DataWriterStubSpy: DataWriter {
        
        enum MessageType {
            case write
        }
        
        var messages: [MessageType] = []
        var data: Data?
        
        func write(to url: URL, options: Data.WritingOptions) throws {
            messages.append(.write)
        }
    }
}
