//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
@testable import ZZImageSliderSwiftUI

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
    
    // MARK: - Helper
    
    private func makeSUT() -> (ZZImageSliderViewModel, TimerSpy) {
        let timerSpy = TimerSpy()
        let sut = ZZImageSliderViewModel(items: Self.mockItems, timer: timerSpy)
        
        return (sut, timerSpy)
    }
    
    private static var mockItems: [ZZImageSliderItem] = {
        return (1...3).map {
            ZZImageSliderItem(
                title: "Title \($0)",
                imageURL: URL(string: "http://url-\($0).com")!
            )
        }
    }()
    
    private class TimerSpy: TimerProtocol {
        enum Message {
            case start, reset, fire
        }
        
        private(set) var messages = [Message]()
        
        var onFire: () -> Void
        
        init() {
            onFire = {}
        }
        
        func start() {
            messages.append(.start)
        }
        
        func reset() {
            messages.append(.reset)
        }
        
        func fire(_ number: Int = 1) {
            for _ in 0..<number {
                onFire()
                messages.append(.fire)
            }
        }
    }
}
