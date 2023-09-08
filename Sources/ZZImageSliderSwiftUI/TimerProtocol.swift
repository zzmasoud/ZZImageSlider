//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import Foundation

public protocol TimerProtocol: AnyObject {
    func start()
    func reset()
    var onFire: (() -> Void)? { set get }
}
