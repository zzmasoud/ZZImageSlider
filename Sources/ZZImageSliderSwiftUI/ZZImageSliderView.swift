//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI
import Combine

struct ZZImageSliderView: View {
    @StateObject var viewModel: ZZImageSliderViewModel
    
    var body: some View {
        GeometryReader { proxy in
            let subItemWidth = proxy.size.width * 0.2
            
            HStack(spacing: 8) {
                mainSliderItemView
                sideSliderItemsView(width: subItemWidth)
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
        VStack(spacing: 8) {
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
}

struct ZZImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZZImageSliderView(
            viewModel: .init(
                items: [
                    .init(title: "Red", subtitle: "Red Color", imageURL: URL(string: "https://picsum.photos/200")!),
                    .init(title: "Green", subtitle: "Green Color", imageURL: URL(string: "https://picsum.photos/400")!),
                    .init(title: "Blue", subtitle: "Blue Color", imageURL: URL(string: "https://picsum.photos/600")!)
                ])
        )
        .previewLayout(.fixed(width: 370, height: 250))
    }
}
