//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
import ZZImageSliderSwiftUI

extension XCTestCase {
    
    // MARK: - Mock Items
    static var mockItems: [ZZImageSliderItem] = {
        return (1...3).map {
            ZZImageSliderItem(
                id: UUID().uuidString,
                title: "Title \($0)"
            )
        }
    }()
    
    // MARK: - FakeImageLoader
    final class FakeImageLoader: ImageLoader {
        func load(id: String) async throws -> UIImage {
            return UIImage()
        }
    }
}
