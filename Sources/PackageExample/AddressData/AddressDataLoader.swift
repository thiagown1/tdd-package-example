//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

public enum LoadAddressDataResult {
    case success(NSDictionary)
    case failure(Error)
}

public protocol AddressDataLoader {
    func load(completion: @escaping (LoadAddressDataResult) -> Void)
}
