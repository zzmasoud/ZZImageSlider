//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

public class ZZImageSliderViewModel: ObservableObject {
    private(set) var items: [ZZImageSliderItem]
    @Published var currentItem: ZZImageSliderItem
    
    public init(items: [ZZImageSliderItem], timer: TimerProtocol) {
        self.items = items
        self.currentItem = items[0]
        timer.start()
        timer.onFire = { [weak self] in
            self?.next()
        }
    }
    
    func didTap(item: ZZImageSliderItem) {
        currentItem = item
    }
    
    private func next() {
        guard var index = items.firstIndex(of: currentItem) else { return }
        index = index < items.endIndex - 1 ? index + 1 : 0
        currentItem = items[index]
    }
}
