import XCTest
@testable import PackageExample

final class PackageExampleTests: XCTestCase {
    
    
    func test_generate_uuid() {
        let sut = makeSUT()
        
        
    }
    
    func test_load_addressData() {
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for completion")
        
        sut.addressProvider.load { result in
            switch result {
            case .success(let dict):
                print("Result: \(dict)")
            case .failure(let error):
                print("Result Error: \(error.localizedDescription)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func makeSUT() -> PackageExample {
        let sut = PackageExample()
        
        return sut
    }
}

/*
 
1. FileSaver
2. FileReader
3. KeyGen
4. KeyManager
 
*/



