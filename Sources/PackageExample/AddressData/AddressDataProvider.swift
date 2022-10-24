//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal class AddressDataProvider: AddressDataLoader {
    
    let client: HTTPClient
    let url: URL
    
    public typealias Result = LoadAddressDataResult
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init (url: URL = URL(string: "http://ip-api.com/json?fields=65798143")!, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping(Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        client.get(from: url, completion: { result in
            print("Client get result: \(result)")
            switch result {
            case .success(let data, _):
                do {
                    if let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        completion(.success(object))
                    }
                } catch {
                    // TODO: Create custom error.
                    completion(.failure(Error.invalidData))
                }
            case .failure:
                completion(.failure(Error.connectivity))
            }
        })
    }
}
