import Foundation

public struct PackageExample {
    
    private var keyManager: KeyManager?
    private var addressProvider: AddressDataProvider?
    
    public init() {
        self.setup()
    }
    
    internal init(keyGen: KeyGen, storage: Storage) {
        self.setup(keyGen: keyGen, storage: storage)
    }
    
    private mutating func setup(keyGen: KeyGen = UUIDKeyGen(),
                                storage: Storage = CompositionRoot().compose()) {
        self.keyManager = KeyManager(keyGen: keyGen, fileManager: storage)
        self.addressProvider = AddressDataProvider(client: URLSessionHTTPClient())
    }
    
    public func configure() {
        // TO-DO: Upload info to server.
        print("Generated UUID: \(keyManager?.writeIfNeeded() ?? "")")
        addressProvider?.load { result in
            switch result {
            case .success(let dict):
                print("Address Data: \(dict)")
            case .failure(let error):
                print("Address Data Error: \(error.localizedDescription)")
            }
        }
    }
}
