//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
import ZZImageSliderSwiftUI

final class TimerUseCaseTests: XCTestCase {
    
    func test_timer_startsAfterInstantiation() {
        let (_, timer) = makeSUT()
        
        XCTAssertEqual(timer.messages, [.start])
    }
    
    // MARK: - Helper
    
    private func makeSUT() -> (ZZImageSliderViewModel, TimerSpy) {
        let mockItems = (1...3).map {
            ZZImageSliderItem(
                title: "Title \($0)",
                imageURL: URL(string: "http://url-\($0).com")!
            )
        }
        
        let timerSpy = TimerSpy()
        let sut = ZZImageSliderViewModel(items: mockItems, timer: timerSpy)
        
        return (sut, timerSpy)
    }
    
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
        
        func fire(_ number: Int) {
            for _ in 0..<number {
                onFire()
                messages.append(.fire)
            }
        }
        
    }
}
