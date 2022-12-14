//
//  File.swift
//  
//
//  Created by Thiago  Wlasenko Nicolau on 24/10/22.
//

import Foundation

internal final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    internal init(session: URLSession = .shared) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error {}

    internal func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            print("data task")
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
