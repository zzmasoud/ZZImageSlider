//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

class ZZImageSliderViewModel: ObservableObject {
    private(set) var items: [ZZImageSliderItem]
    private var timer: TimerProtocol
    
    init(items: [ZZImageSliderItem], timer: TimerProtocol = DefaultTimer(timeInterval: 2)) {
        self.items = items
        self.currentItem = items[0]
        self.timer = timer
        timer.start()
        timer.onFire = { [weak self] in
            self?.next()
        }
        Task {
            await downloadImages()
        }
    }
    
    @Published var currentItem: ZZImageSliderItem
    private var images: [URL: UIImage] = [:]
    var currentImage: UIImage? { images[currentItem.id] }
    
    func downloadImages() async {
        for item in items {
            do {
                let (data, _) = try await URLSession.shared.data(from: item.imageURL)
                let image = UIImage(data: data)
                images[item.id] = image
            } catch {
                images[item.id] = nil
            }
        }
    }
    
    func imageFor(item: ZZImageSliderItem) -> UIImage? {
        images[item.id]
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
