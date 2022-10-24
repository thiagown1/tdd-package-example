public struct PackageExample {
    private var storage = LocalFileManager(localPath: "e")
    private var keyGen = UUIDKeyGen()
    
    private let keyManager: KeyManager
    internal let addressProvider: AddressDataProvider
    
    public init() {
        keyManager = KeyManager(keyGen: keyGen, fileManager: storage)
        addressProvider = AddressDataProvider(client: URLSessionHTTPClient())
    }
    
    public func configure() {
        // TO-DO: Upload info to server.
        print("Generated UUID: \(keyManager.writeIfNeeded())")
        addressProvider.load { result in
            switch result {
            case .success(let dict):
                print("Address Data: \(dict)")
            case .failure(let error):
                print("Address Data Error: \(error.localizedDescription)")
            }
        }
    }
}
