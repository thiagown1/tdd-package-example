//
//  AddressDataProviderTests.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

@testable import PackageExample
import XCTest

class AddressDataProviderTests: XCTestCase {
    
    func test_init_doesNotInvokeAnything() {
        let (_, clientSpy) = makeSUT(url: anyURL())
        
        XCTAssertTrue(clientSpy.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = anyURL()
        let (sut, clientSpy) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(clientSpy.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = anyURL()
        let (sut, clientSpy) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(clientSpy.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT(url: anyURL())

        expect(sut, toCompleteWith: failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT(url: anyURL())

        let samples = [199, 201, 300, 400, 500]
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let json = Data()
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT(url: anyURL())

        expect(sut, toCompleteWith: failure(.invalidData), when: {
            let invalidJSON = Data("invalid-json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT(url: anyURL())

        let dict = """
        {
            "name": "test"
        }
        """

        expect(sut,
               toCompleteWith: .success(["name": "test"]),
               when: {
                    client.complete(withStatusCode: 200,
                                    data: dict.data(using: .utf8, allowLossyConversion: false)!)
        })
    }
    
    private func makeSUT(url: URL) -> (AddressDataProvider, HTTPClientSpy) {
        let clientSpy = HTTPClientSpy()
        let sut = AddressDataProvider(url: url, client: clientSpy)
        
        
        return (sut, clientSpy)
    }
    
    private func expect(_ sut: AddressDataLoader, toCompleteWith expectedResult: AddressDataProvider.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)

            case let (.failure(receivedError as AddressDataProvider.Error), .failure(expectedError as AddressDataProvider.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        action()

        wait(for: [exp], timeout: 1.0)
    }

    private func failure(_ error: AddressDataProvider.Error) -> AddressDataProvider.Result {
        return .failure(error)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index], statusCode: code, httpVersion: nil, headerFields: nil)!
            messages[index].completion(.success(data, response))
        }
    }

}
