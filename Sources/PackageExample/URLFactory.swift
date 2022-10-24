//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal protocol URLFactory {
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
}

extension FileManager: URLFactory {}
