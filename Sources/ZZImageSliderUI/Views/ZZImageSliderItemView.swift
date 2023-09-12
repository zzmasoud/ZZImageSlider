//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct ZZImageSliderItemView: View {
    @Binding var image: UIImage?

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
