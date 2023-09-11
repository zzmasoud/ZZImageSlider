//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
@testable import ZZImageSliderSwiftUI

final class ItemSelectionDelegateTests: XCTestCase {
    
    func test_delegate_triggersOnMainItemSelection() {
        let (sut, delegate) = makeSUT()
        
        XCTAssertTrue(delegate.calls.isEmpty)
        sut.didTapItem()
        
        XCTAssertEqual(delegate.calls, [sut.currentItem])
    }
    
    // MARK: - Helper
    
    private func makeSUT() -> (ZZImageSliderViewModel, DelegateSpy) {
        let delegate = DelegateSpy()
        let sut = ZZImageSliderViewModel(items: Self.mockItems, delegate: delegate, imageLoader: FakeImageLoader())
        
        return (sut, delegate)
    }
        
    private final class DelegateSpy: ZZImageSliderViewDelegagte {
        
        private(set) var calls: [ZZImageSliderSwiftUI.ZZImageSliderItem] = []
        
        func didTap(item: ZZImageSliderSwiftUI.ZZImageSliderItem) {
            calls.append(item)
        }
    }
}
