//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import Foundation

final public class DefaultTimer: TimerProtocol {
    private let timeInterval: TimeInterval
    private var timer: Timer?
    public var onFire: (() -> Void)?

    public init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    public func start() {
        timer?.invalidate()
        
        // Create and start a new timer
        timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(timerFired),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func timerFired() {
        onFire?()
    }
    
    public func reset() {
        timer?.invalidate()
        start()
    }
}
