//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
