//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import Foundation

public struct ZZImageSliderItem: Identifiable, Equatable {
    let title: String?
    let subtitle: String?
    let imageURL: URL
    
    init(title: String, imageURL: URL) {
        (self.title, self.subtitle, self.imageURL) = (title, nil, imageURL)
    }
    
    init(subtitle: String, imageURL: URL) {
        (self.title, self.subtitle, self.imageURL) = (nil, subtitle, imageURL)
    }
    
    init(title: String, subtitle: String, imageURL: URL) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
    public var id: URL { imageURL }
}
