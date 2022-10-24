//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation
import XCTest

extension XCTestCase {
    internal func anyString() -> String {
        return "AnyString"
    }
    
    internal func anyOtherString() -> String {
        return "Any Other String"
    }
    
    internal func anyURL(appending: String = "") -> URL {
        return URL(string: "https://a.com" + appending)!
    }
    
    internal func anyOtherURL() -> URL {
        return URL(string: "https://b.com")!
    }
    
    internal func anyData() -> Data {
        return Data("any data".utf8)
    }

    internal func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }

    internal func nonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }

    internal func anyHTTPURLResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
}
