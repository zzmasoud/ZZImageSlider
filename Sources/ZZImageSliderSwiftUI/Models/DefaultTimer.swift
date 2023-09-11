//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import Foundation

final class DefaultTimer: TimerProtocol {
    var timer: Timer?
    var timeInterval: TimeInterval
    var onFire: (() -> Void)?

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    func start() {
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
    
    func reset() {
        timer?.invalidate()
        start()
    }
}
