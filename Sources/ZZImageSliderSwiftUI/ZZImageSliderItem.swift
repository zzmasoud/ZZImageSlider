//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import Foundation

public struct ZZImageSliderItem: Identifiable, Equatable {
    public let title: String?
    public let subtitle: String?
    public let imageURL: URL
    
    public init(title: String, imageURL: URL) {
        (self.title, self.subtitle, self.imageURL) = (title, nil, imageURL)
    }
    
    public init(subtitle: String, imageURL: URL) {
        (self.title, self.subtitle, self.imageURL) = (nil, subtitle, imageURL)
    }
    
    public init(title: String, subtitle: String, imageURL: URL) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
    public var id: URL { imageURL }
}
