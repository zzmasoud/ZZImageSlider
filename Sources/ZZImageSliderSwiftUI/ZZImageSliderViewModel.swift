//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

public class ZZImageSliderViewModel: ObservableObject {
    private var cancellables = [AnyCancellable]()
    private(set) var items: [ZZImageSliderItem]
    @Published var currentItem: ZZImageSliderItem

    init(items: [ZZImageSliderItem]) {
        self.items = items
        self.currentItem = items[0]
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.next()
            }
            .store(in: &cancellables)
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
