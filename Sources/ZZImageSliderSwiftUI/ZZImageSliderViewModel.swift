//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

class ZZImageSliderViewModel: ObservableObject {
    private(set) var items: [ZZImageSliderItem]
    @Published var currentItem: ZZImageSliderItem
    private var timer: TimerProtocol
    
    init(items: [ZZImageSliderItem], timer: TimerProtocol = DefaultTimer(timeInterval: 1)) {
        self.items = items
        self.currentItem = items[0]
        self.timer = timer
        timer.start()
        timer.onFire = { [weak self] in
            self?.next()
        }
    }
    
    func didTap(item: ZZImageSliderItem) {
        currentItem = item
        timer.reset()
    }
    
    private func next() {
        guard var index = items.firstIndex(of: currentItem) else { return }
        index = index < items.endIndex - 1 ? index + 1 : 0
        currentItem = items[index]
    }
}
