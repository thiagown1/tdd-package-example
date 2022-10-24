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
}
