//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

struct ZZImageSliderView: View {
    enum Position {
        case leading, trailing, top, bottom
    }
    
    @StateObject var viewModel: ZZImageSliderViewModel
    
    /// Percentage of a total available width for the view.
    /// default is `0.2` (20%)
    var sideItemsWidth: CGFloat = 0.2
    
    /// Space for the stack showing slide items
    /// default is `8`
    var spaceBetweenItems: CGFloat = 8
    
    /// Position of the side items
    /// default is `.trailing`
    var sideItemsPosition: Position = .trailing
    
    init(viewModel: ZZImageSliderViewModel, sideItemWidth: CGFloat = 0.2, spaceBetweenItems: CGFloat = 8, sideItemsPosition: Position = .trailing) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.sideItemsWidth = sideItemWidth
        self.spaceBetweenItems = spaceBetweenItems
        self.sideItemsPosition = sideItemsPosition
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            switch sideItemsPosition {
            case .leading, .trailing:
                let subItemWidth = proxy.size.width * sideItemsWidth
                let sideItemsView = sideSliderItemsView(width: subItemWidth)
                HStack(spacing: spaceBetweenItems) {
                    if sideItemsPosition == .trailing {
                        mainSliderItemView
                        sideItemsView
                    } else {
                        sideItemsView
                        mainSliderItemView
                    }
                }
            case .top, .bottom:
                VStack(spacing: spaceBetweenItems) {
                    let subItemHeight = proxy.size.height * sideItemsWidth
                    let sideItemsView = sideSliderItemsView(height: subItemHeight)
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
    
    private var mainSliderItemView: some View {
        ZStack {
            VStack {
                mainView
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
    
    private func sideSliderItemsView(width subItemWidth: CGFloat) -> some View {
        VStack(spacing: spaceBetweenItems) {
            ForEach(viewModel.items) { item in
                ZZImageSliderItemView(image: viewModel.imageFor(item: item))
                    .frame(width: subItemWidth, height: subItemWidth * 0.75)
                    .background(Color.secondary)
                    .cornerRadius(8)
                    .onTapGesture { viewModel.didTap(item: item) }
            }
        }
        .frame(width: subItemWidth)
        .padding(.vertical)
    }
    
    private func sideSliderItemsView(height subItemHeight: CGFloat) -> some View {
        HStack(spacing: spaceBetweenItems) {
            ForEach(viewModel.items) { item in
                ZZImageSliderItemView(image: viewModel.imageFor(item: item))
                    .frame(width: subItemHeight * 1.2, height: subItemHeight)
                    .background(Color.secondary)
                    .cornerRadius(8)
                    .onTapGesture { viewModel.didTap(item: item) }
            }
        }
        .frame(height: subItemHeight)
        .padding(.horizontal)
    }
}

struct ZZImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        let items: [ZZImageSliderItem] = [
            .init(title: "Red", subtitle: "Red Color", imageURL: URL(string: "https://picsum.photos/200")!),
            .init(title: "Green", subtitle: "Green Color", imageURL: URL(string: "https://picsum.photos/400")!),
            .init(title: "Blue", subtitle: "Blue Color", imageURL: URL(string: "https://picsum.photos/600")!)
        ]
        
        ZZImageSliderView(
            viewModel: .init(items: items)
        )
        .frame(width: 370, height: 250)
        .previewDisplayName("Vertical Style")
        
        ZZImageSliderView(
            viewModel: .init(items: items),
            sideItemsPosition: .bottom
        )
        .frame(width: 370, height: 370)
        .previewDisplayName("Horizontal Style")
    }
}
