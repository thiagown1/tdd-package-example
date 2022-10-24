//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 23/10/22.
//

import Foundation

public protocol FileSaver {
    func write(dataString: String) throws
}

public protocol FileReader {
    func read() throws -> String?
}

public typealias Storage = FileSaver & FileReader

public class LocalFileManager: Storage {
    
    let localPath: String
    let urlFactory: URLFactory
    let stringReader: StringFileReader
    
    public enum Exceptions: Error, Equatable {
        case noURL
    }
    
    public init(localPath: String = "", urlFactory: URLFactory = FileManager.default, stringReader: StringFileReader = StringReader()) {
        self.localPath = localPath
        self.urlFactory = urlFactory
        self.stringReader = stringReader
    }
    
    public func write(dataString: String) throws {
        guard let firstPath = self.urlFactory.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first else {
            throw Exceptions.noURL
        }
        let path = firstPath.appendingPathComponent(self.localPath)

        stringReader.to(url: path, stringData: dataString)
    }
    
    public func read() throws -> String? {
        
        guard let firstPath = self.urlFactory.urls(for: .documentDirectory,
                                              in: .userDomainMask).first else {
            throw Exceptions.noURL
        }
        
        let path = firstPath.appendingPathComponent(self.localPath)
        return stringReader.from(contentsOf: path, encoding: .utf8)
    }
}



