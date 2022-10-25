//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 25/10/22.
//

import Foundation

internal protocol Encryptor {
    func encrypt(_ dataString: String) -> String?
    func decrypt(_ dataString: String) -> String?
}
