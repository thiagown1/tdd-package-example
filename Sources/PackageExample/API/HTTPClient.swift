//
//  File.swift
//
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

internal protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
