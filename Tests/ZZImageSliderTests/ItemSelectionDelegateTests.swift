//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
import TestHelper
import ZZImageSlider

@MainActor
final class ItemSelectionDelegateTests: XCTestCase {
    
    func test_delegate_triggersOnMainItemSelection() {
        let (sut, delegate) = makeSUT()
        
        XCTAssertTrue(delegate.calls.isEmpty)
        sut.didTapItem()
        
        XCTAssertEqual(delegate.calls, [sut.currentItem])
    }
    
    // MARK: - Helper
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ZZImageSliderViewModel, DelegateSpy) {
        let delegate = DelegateSpy()
        let loader = FakeImageLoader()
        let sut = ZZImageSliderViewModel(
            items: Self.mockItems,
            delegate: delegate,
            imageLoader: loader
        )
        
        trackForMemoryLeaks(delegate, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)

        return (sut, delegate)
    }
}
