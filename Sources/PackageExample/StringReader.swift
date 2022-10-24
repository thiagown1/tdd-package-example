//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal class StringReader: StringFileReader {
    
    internal init() {}
    
    internal func from(contentsOf url: URL, encoding enc: String.Encoding) -> String? {
        return try? String(contentsOf: url, encoding: enc)
    }
    
    internal func to(url: URL, stringData: StringData) {
        if let data = stringData.dataWritter(using: .utf8, allowLossyConversion: false) {
            try? data.write(to: url, options: [])
        }
    }
}

internal protocol StringData {
    func dataWritter(using encoding: String.Encoding, allowLossyConversion: Bool) -> DataWriter?
}

internal protocol DataWriter {
    func write(to url: URL, options: Data.WritingOptions) throws
}

extension String: StringData {
    internal func dataWritter(using encoding: Encoding, allowLossyConversion: Bool) -> DataWriter? {
        self.data(using: encoding, allowLossyConversion: allowLossyConversion)
    }
}
extension Data: DataWriter { }

internal protocol StringFileReader {
    func from(contentsOf url: URL, encoding enc: String.Encoding) -> String?
    func to(url: URL, stringData: StringData)
}
