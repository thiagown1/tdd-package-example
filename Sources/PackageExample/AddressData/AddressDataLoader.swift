//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal enum LoadAddressDataResult {
    case success(NSDictionary)
    case failure(Error)
}

internal protocol AddressDataLoader {
    func load(completion: @escaping (LoadAddressDataResult) -> Void)
}
