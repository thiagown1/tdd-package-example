//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation
import XCTest

extension XCTestCase {
    public func anyString() -> String {
        return "AnyString"
    }
    
    public func anyOtherString() -> String {
        return "Any Other String"
    }
    
    public func anyURL(appending: String = "") -> URL {
        return URL(string: "https://a.com" + appending)!
    }
    
    public func anyOtherURL() -> URL {
        return URL(string: "https://b.com")!
    }
    
    public func anyData() -> Data {
        return Data("any data".utf8)
    }

    public func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }

    public func nonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }

    public func anyHTTPURLResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
}
