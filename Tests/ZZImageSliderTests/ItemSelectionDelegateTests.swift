//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
import TestHelper
import ZZImageSlider

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
        let loader = FakeImageLoader()
        let sut = ZZImageSliderViewModel(
            items: Self.mockItems,
            delegate: delegate,
            imageLoader: loader
        )
        
        trackForMemoryLeaks(delegate)
        trackForMemoryLeaks(loader)
        trackForMemoryLeaks(sut)

        return (sut, delegate)
    }
}
