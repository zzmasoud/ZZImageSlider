//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
import TestHelper
import ZZImageSlider

@MainActor
final class TimerUseCaseTests: XCTestCase {
    
    func test_timer_startsAfterInstantiation() {
        let (_, timer) = makeSUT()
        
        XCTAssertEqual(timer.messages, [.start])
    }
    
    func test_onTimerFire_nextItemIsSelected() {
        let startIndex = Self.mockItems.startIndex
        let (sut, timer) = makeSUT()
        XCTAssertEqual(sut.currentItem, Self.mockItems[startIndex])
        
        timer.fire()
        XCTAssertEqual(sut.currentItem, Self.mockItems[startIndex + 1])
    }
    
    func test_didTap_resetsTiemr() {
        let (sut, timer) = makeSUT()

        sut.didTap(item: Self.mockItems.randomElement()!)
        
        XCTAssertEqual(timer.messages, [.start, .reset])
    }
    
    // MARK: - Helper
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ZZImageSliderViewModel, TimerSpy) {
        let timerSpy = TimerSpy()
        let loader = FakeImageLoader()
        let sut = ZZImageSliderViewModel(
            items: Self.mockItems,
            timer: timerSpy,
            imageLoader: loader
        )
        
        trackForMemoryLeaks(timerSpy, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, timerSpy)
    }
}
