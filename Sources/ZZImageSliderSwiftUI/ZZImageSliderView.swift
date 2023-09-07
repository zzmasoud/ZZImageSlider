//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ZZImageSliderView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 8) {
                Rectangle()
                VStack(spacing: 8) {
                    Rectangle()
                    Rectangle()
                    Rectangle()
                    Rectangle()
                }
                .frame(width: proxy.size.width * 0.2)
            }
        }
    }
}

struct ZZImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZZImageSliderView()
            .previewLayout(.fixed(width: 370, height: 200))
    }
}
