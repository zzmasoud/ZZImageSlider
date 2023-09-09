//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ZZImageSliderItemView: View {
    var image: UIImage?

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()                
            }
            else {
                ProgressView()
            }
        }
    }
}

struct ZZImageSliderItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZZImageSliderItemView(image: .none)
            .frame(width: 300, height: 150)
    }
}
