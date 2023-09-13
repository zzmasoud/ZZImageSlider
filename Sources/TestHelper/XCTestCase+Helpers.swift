//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import XCTest
import ZZImageSlider

public extension XCTestCase {
    
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
        public init() {}
        
        public func load(id: String) async throws -> UIImage {
            return UIImage()
        }
    }
    
    // MARK: - DelegateSpy
    final class DelegateSpy: ZZImageSliderViewDelegagte {
        public init() {}
        
        private(set) public var calls: [ZZImageSliderItem] = []
        
        public func didTap(item: ZZImageSlider.ZZImageSliderItem) {
            calls.append(item)
        }
    }
    
    final class TimerSpy: TimerProtocol {
        public enum Message {
            case start, reset, fire
        }
        
        public init() {}
        
        private(set) public var messages = [Message]()
        
        public var onFire: (() -> Void)?
        
        public func start() {
            messages.append(.start)
        }
        
        public func reset() {
            messages.append(.reset)
        }
        
        public func fire(_ number: Int = 1) {
            for _ in 0..<number {
                onFire?()
                messages.append(.fire)
            }
        }
    }
}
