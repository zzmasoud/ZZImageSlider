//
//  ZZSliderConfigs.swift
//  ZZSlider
//
//  Created by Masoud Sheikh Hosseini on 12/06/2020.
//  Copyright (c) 2020 zzmasoud. All rights reserved.
//

import UIKit

public struct ZZSliderConfigs {
    
    /// The struct to configure Slider's ImageView
    public struct ImageView {
        
        /// The enum to configure item's text background.
        public enum TextBackgroundStyle {
            case solid(color: UIColor)
            case gradient(colors: [UIColor])
        }
        
        /// The content mode of slider's `imageView`. Defaults to `.scaleAspectFill`.
        public var contentMode: UIView.ContentMode = .scaleAspectFill
        
        /// The background color of `imageView` when image is not setted yet. Defaults to `.lightGray`.
        public var emptyBackgroundColor: UIColor = .lightGray
        
        /// The background style of imageView's `label`. Defaults to `.gradient(colors: [UIColor.black.withAlphaComponent(0), UIColor.black.withAlphaComponent(0.45)])`.
        public var textBackgroundStyle: TextBackgroundStyle = .gradient(colors: [UIColor.black.withAlphaComponent(0), UIColor.black.withAlphaComponent(0.45)])
        
        /// The font of imageView's `label`. Defaults to `UIFont.preferredFont(forTextStyle: .body)`.
        public var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
        
        /// The text color of imageView's `label`. Defaults to `.white`.
        public var textColor: UIColor = .white
        
        /// The corner radius of imageView's layer. Defaults to `20`.
        public var cornerRadius: CGFloat = 20
        
        // this is a tricky way to pass this value to ZZSliderImageView so that it knows how to animate it's label fade in/out.
        var slideDuration: TimeInterval = 5
    }
    
    /// The struct to configure Slider's items
    public struct Items {
        
        /// The enum to present selection style of each slide's item
        public enum SelectionStyle {
            case border(color: UIColor, width: CGFloat)
            case none
        }

        /// The background color of item when image is not setted yet. Defaults to `.lightGray`.
        public var emptyBackgroundColor: UIColor = .lightGray
        
        /// The `edgeInsets` of items `UIStackView`, use this property to make space between `imageView` and `items`. Defaults to `UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)`.
        public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
        
        /// The spacing between items. Defaults to `16`.
        public var spacing: CGFloat = 16
        
        /// The corner radius of each item's layer. Defaults to `8`.
        public var cornerRadius: CGFloat = 8
        
        /**
        The size percent of items `UIStackView`. Defaults to `0.2`.

        - slider axis:
            - horizontal: it means height
            - vertical: it means width
        */
        public var sizePercent: CGFloat = 0.2
        
        /// The selection style of each item. Defaults to `.none`.
        public var selectionStyle: SelectionStyle = .none
    }
    
    /// The duration to display each slider's item on imageView. Defaults to `5.0`.
    public var slideDuration: TimeInterval = 5.0 {
        didSet {
            imageView.slideDuration = slideDuration
        }
    }
    
    /**
    The slider's axis. Defaults to `.horizontal`.
     
     - axis:
        - horizontal: imageView on top and items on bottom
        - vertical: imageView on leading and items on trailing
    */
    public var sliderAxis: NSLayoutConstraint.Axis = .horizontal {
        didSet {
            sliderAxis = sliderAxis == .horizontal ? .vertical : .horizontal
        }
    }

    /// The configurations of slider's `imageView`.
    public var imageView: ImageView = ImageView()
    
    /// The configurations of slider's `items`.
    public var items: Items = Items()
    
    public init() {}
}
