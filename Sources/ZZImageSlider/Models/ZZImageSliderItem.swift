//
//  Copyright © zzmasoud (github.com/zzmasoud).
//  

import Foundation

public struct ZZImageSliderItem: Identifiable, Equatable {
    public let id: String
    public let title: String?
    public let subtitle: String?
    
    public init(id: String, title: String) {
        (self.id, self.title, self.subtitle) = (id, title, nil)
    }
    
    public init(id: String, subtitle: String) {
        (self.id, self.title, self.subtitle) = (id, nil, subtitle)
    }
    
    public init(id: String, title: String, subtitle: String) {
        (self.id, self.title, self.subtitle) = (id, title, subtitle)
    }
}
