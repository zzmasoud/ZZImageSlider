//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

class ZZImageSliderViewModel: ObservableObject {
    private(set) var items: [ZZImageSliderItem]
    private var timer: TimerProtocol
    private var delegate: ZZImageSliderViewDelegagte?
    private var imageLoader: ImageLoader
    
    init(items: [ZZImageSliderItem], timer: TimerProtocol = DefaultTimer(timeInterval: 2), delegate: ZZImageSliderViewDelegagte? = nil, imageLoader: ImageLoader) {
        self.items = items
        self.currentItem = items[0]
        self.timer = timer
        self.delegate = delegate
        self.imageLoader = imageLoader
        
        timer.start()
        timer.onFire = { [weak self] in
            self?.next()
        }
        Task {
            await downloadImages()
        }
    }
    
    @Published var currentItem: ZZImageSliderItem
    private var images: [String: UIImage] = [:]
    var currentImage: UIImage? { images[currentItem.id] }
    
    func downloadImages() async {
        for item in items {
            do {
                let image = try await imageLoader.load(id: item.id)
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
    
    func didTapItem() {
        delegate?.didTap(item: currentItem)
    }
    
    private func next() {
        guard var index = items.firstIndex(of: currentItem) else { return }
        index = index < items.endIndex - 1 ? index + 1 : 0
        currentItem = items[index]
    }
}