//
//  ZZSliderItem.swift
//  ZZSlider
//
//  Created by Masoud Sheikh Hosseini on 12/06/2020.
//  Copyright (c) 2020 zzmasoud. All rights reserved.
//

import UIKit

public protocol ZZSliderItem {
    var text: String? { get }
    func load(with completion: @escaping (_ image: UIImage?) -> Void)
}

@objcMembers
open class UIImageSliderItem: ZZSliderItem {
    public var text: String?
    var image: UIImage
    
    public func load(with completion: @escaping (UIImage?) -> Void) {
        completion(image)
    }
    
    public init(image: UIImage, text: String?) {
        self.image = image
        self.text = text
    }
}

@objcMembers
open class BundleSliderItem: ZZSliderItem {
    public var text: String?
    var imageName: String
    
    public init(imageName: String, text: String?) {
        self.imageName = imageName
        self.text = text
    }
    
    public func load(with completion: @escaping (UIImage?) -> Void) {
        let image = UIImage(named: imageName)
        completion(image)

    }
}
