//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import SwiftUI

struct FadeView: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: .init(colors: [Color.black.opacity(0), Color.black.opacity(0.4)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

struct FadeView_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .fill(Color.gray)
            .previewLayout(.fixed(width: 350, height: 250))
            .overlay(
                FadeView()
                    .frame(height: 50)
            )
    }
}
