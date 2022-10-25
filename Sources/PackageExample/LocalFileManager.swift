//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation

internal protocol FileSaver {
    func write(dataString: String) throws
}

internal protocol FileReader {
    func read() throws -> String?
}

internal typealias Storage = FileSaver & FileReader

internal class LocalFileManager: Storage {
    
    let localPath: String
    let urlFactory: URLFactory
    let stringReader: StringFileReader
    
    internal enum Exceptions: Error, Equatable {
        case noURL
    }
    
    internal init(localPath: String = "", urlFactory: URLFactory = FileManager.default, stringReader: StringFileReader = StringReader()) {
        self.localPath = localPath
        self.urlFactory = urlFactory
        self.stringReader = stringReader
    }
    
    internal func write(dataString: String) throws {
        guard let firstPath = self.urlFactory.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first else {
            throw Exceptions.noURL
        }
        let path = firstPath.appendingPathComponent(self.localPath)

        stringReader.to(url: path, stringData: dataString)
    }
    
    internal func read() throws -> String? {
        
        guard let firstPath = self.urlFactory.urls(for: .documentDirectory,
                                              in: .userDomainMask).first else {
            throw Exceptions.noURL
        }
        
        let path = firstPath.appendingPathComponent(self.localPath)
        return stringReader.from(contentsOf: path, encoding: .utf8)
    }
}


