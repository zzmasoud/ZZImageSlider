//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import XCTest
import TestHelper
import SnapshotTesting
@testable import ZZImageSlider
@testable import ZZImageSliderUI

@MainActor
final class ZZImageSliderViewSnapshotTests: XCTestCase {
    
    func test_loadingState() {
        let (sut, _, _ ) = makeSUT()
        
        assertSnapshot(of: sut, as: .image)
    }
    
    func test_loadedImagesState() {
        let (sut, loader, viewModel) = makeSUT()
        let item1 = Self.mockItems[0]
        let item2 = Self.mockItems[1]
        let item3 = Self.mockItems[2]

        loader.complete(with: .success(.make(withColor: .red)), for: item1.id)
        loader.complete(with: .success(.make(withColor: .green)), for: item2.id)
        loader.complete(with: .success(.make(withColor: .blue)), for: item3.id)
        
        assertSnapshot(of: sut, as: .image, record: true)
        
        viewModel.didTap(item: item2)
        
        assertSnapshot(of: sut, as: .image, record: true)
        
        viewModel.didTap(item: item3)

        assertSnapshot(of: sut, as: .image, record: true)
    }

    
    // MARK: - Helpers
    
    private func makeSUT() -> (some View, ImageLoaderStub, ZZImageSliderViewModel) {
        let imageLoader = ImageLoaderStub()
        let viewModel = ZZImageSliderViewModel(items: Self.mockItems, timer: TimerSpy(), delegate: nil, imageLoader: imageLoader)
        let sut = ZZImageSliderView(viewModel: viewModel)
            .frame(width: 370, height: 270)
        return (sut, imageLoader, viewModel)
    }
    
    private final class ImageLoaderStub: ImageLoader {
        private var continuations: [String: CheckedContinuation<UIImage, Error>] = [:]
        
        func load(id: String) async throws -> UIImage {
            return try await withCheckedThrowingContinuation({ continuation in
                self.continuations[id] = continuation
            })
        }
        
        func complete(with result: Result<UIImage, Error>, for id: String) {
            continuations[id]?.resume(with: result)
        }
    }
}


extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: rect.size, format: format).image { rendererContext in
            color.setFill()
            rendererContext.fill(rect)
        }
    }
}
