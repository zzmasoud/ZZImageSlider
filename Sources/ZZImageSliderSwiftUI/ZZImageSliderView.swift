//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

protocol ZZImageSliderViewDelegagte {
    func didTap(item: ZZImageSliderItem)
}

struct ZZImageSliderView: View {
    enum Position {
        case leading, trailing, top, bottom
    }
    
    enum AspectRatio {
        case square, rectangle(ratio: CGFloat)
    }
    
    @StateObject var viewModel: ZZImageSliderViewModel
    
    /// Space for the stack showing side items
    /// default is `8`
    var sideItemsSpace: CGFloat
    
    /// Position of the side items
    /// default is `.trailing`
    var sideItemsPosition: Position
    
    /// strech the side view as available space, it will be width for horizontal positions and height for vertical positions
    /// default is `0.2` (20%)
    var sideItemsShare: CGFloat
    
    /// Each side item aspect ratio
    /// default is `.square`
    var eachSideItemAspectRatio: AspectRatio
    
    init(viewModel: ZZImageSliderViewModel,
         sideItemsShare: CGFloat = 0.2,
         spaceBetweenItems: CGFloat = 8,
         sideItemsPosition: Position = .trailing,
         eachSideItemAspectRatio: AspectRatio = .square
    ) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.sideItemsShare = sideItemsShare
        self.sideItemsSpace = spaceBetweenItems
        self.sideItemsPosition = sideItemsPosition
        self.eachSideItemAspectRatio = eachSideItemAspectRatio
    }
    
    var body: some View {
        GeometryReader { proxy in
            if isVertical {
                let sideItemWidth = proxy.size.width * sideItemsShare
                let sideItemSize = calculateSubItemSize(sideItemWidth)
                let sideItemsView = sideSliderItemsView(size: sideItemSize)
                    .frame(width: sideItemWidth)
                
                HStack(spacing: sideItemsSpace) {
                    if sideItemsPosition == .trailing {
                        mainSliderItemView
                        sideItemsView
                    } else {
                        sideItemsView
                        mainSliderItemView
                    }
                }
            } else {
                let sideItemHeight = proxy.size.height * sideItemsShare
                let sideItemSize = calculateSubItemSize(sideItemHeight)
                let sideItemsView = sideSliderItemsView(size: sideItemSize)
                    .frame(width: sideItemHeight)
                
                VStack(spacing: sideItemsSpace) {
                    if sideItemsPosition == .bottom {
                        mainSliderItemView
                        sideItemsView
                    } else {
                        sideItemsView
                        mainSliderItemView
                    }
                }
            }
        }
    }
    
    private var isVertical: Bool { sideItemsPosition == .leading || sideItemsPosition == .trailing }
    
    private var mainSliderItemView: some View {
        ZStack {
            VStack {
                mainView
                    .onTapGesture { viewModel.didTapItem() }
            }
            VStack {
                Spacer()
                textsView
            }
        }
        .cornerRadius(16)
    }
    
    private var mainView: AnyView {
        if let image = viewModel.currentImage {
            return AnyView(
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(16)
                    .animation(.easeIn, value: image)
            )
        } else {
            return AnyView(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray)
            )
        }
    }
    
    private var textsView: some View {
        VStack(alignment: .leading) {
            if let title = viewModel.currentItem.title {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                    .animation(.easeIn, value: title)
            }
            
            if let subtitle = viewModel.currentItem.subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .lineLimit(1)
                    .animation(.easeIn, value: subtitle)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .padding(.horizontal, 2)
        .foregroundColor(.white)
        .background(
            FadeView()
                .padding(.top, -8)
        )
    }
    
    private func sideSliderItemsView(size: CGSize) -> AnyView {
        let views = ForEach(viewModel.items) { item in
            ZZImageSliderItemView(image: viewModel.imageFor(item: item))
                .frame(width: size.width, height: size.height)
                .background(Color.secondary)
                .cornerRadius(8)
                .onTapGesture { viewModel.didTap(item: item) }
        }
        if isVertical {
            return AnyView(
                VStack(spacing: sideItemsSpace) {
                    views
                }
                    .padding(.vertical)
            )
        } else {
            return AnyView(
                HStack(spacing: sideItemsSpace) {
                    views
                }
                    .padding(.horizontal)
            )
        }
    }
    
    private func calculateSubItemSize(_ number: CGFloat) -> CGSize {
        switch eachSideItemAspectRatio {
        case .square:
            return CGSize(width: number, height: number)
        case .rectangle(let ratio):
            if isVertical {
                return CGSize(width: number, height: number * ratio)
            } else {
                return CGSize(width: number * ratio, height: number)
            }
        }
    }
}

struct ZZImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        let items: [ZZImageSliderItem] = [
            .init(id: UUID().uuidString, title: "Red", subtitle: "Red Color"),
            .init(id: UUID().uuidString, title: "Green", subtitle: "Green Color"),
            .init(id: UUID().uuidString, title: "Blue", subtitle: "Blue Color")
        ]
        
        ZZImageSliderView(
            viewModel: .init(items: items, imageLoader: RemoteImageLoader(session: .shared, urlFetcher: { id in
                return URL(string: "https://picsum.photos/200")!
            }))
        )
        .frame(width: 370, height: 250)
        .previewDisplayName("Vertical Style")
        
        ZZImageSliderView(
            viewModel: .init(items: items, imageLoader: RemoteImageLoader(session: .shared, urlFetcher: { id in
                return URL(string: "https://picsum.photos/200")!
            })),
            sideItemsShare: 0.15,
            sideItemsPosition: .bottom,
            eachSideItemAspectRatio: .rectangle(ratio: 1.35)
        )
        .frame(width: 370, height: 370)
        .previewDisplayName("Horizontal Style")
    }
}
