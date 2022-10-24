//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal protocol UUIDFactory {
    var uuidString: String { get }
}

extension UUID: UUIDFactory { }
