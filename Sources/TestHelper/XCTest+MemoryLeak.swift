//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest

public extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Potential memory leak found! Instance should have been deallocated.", file: file, line: line)
        }
    }
}
