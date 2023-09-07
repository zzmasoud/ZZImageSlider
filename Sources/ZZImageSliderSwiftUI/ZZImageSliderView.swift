//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct Model: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

class ZZImageSliderViewModel: ObservableObject {
    private(set) var items: [Model] = [
        .init(title: "Red", subtitle: "Red Color"),
        .init(title: "Green", subtitle: "Green Color"),
        .init(title: "Blue", subtitle: "Blue Color"),
    ]
    
    @Published var currentItem: Model
    
    init() {
        self.currentItem = items[0]
    }
    
    func didTap(item: Model) {
        currentItem = item
    }
}

struct ZZImageSliderView: View {
    @StateObject var viewModel: ZZImageSliderViewModel
    
    var body: some View {
        GeometryReader { proxy in
            let subItemWidth = proxy.size.width * 0.2
            
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray)
                    VStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(viewModel.currentItem.title)
                                .font(.headline)
                            Text(viewModel.currentItem.subtitle)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .padding(.horizontal, 2)
                        .background(Color.secondary)
                        
                    }
                }
                .cornerRadius(16)
                VStack(spacing: 8) {
                    ForEach(viewModel.items) { item in
                        RoundedRectangle(cornerRadius: 8)
                            .onTapGesture {
                                viewModel.didTap(item: item)
                            }
                    }
                }
                .frame(width: subItemWidth)
            }
        }
    }
}

struct ZZImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZZImageSliderView(viewModel: .init())
            .previewLayout(.fixed(width: 370, height: 200))
    }
}
