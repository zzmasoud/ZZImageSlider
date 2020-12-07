//
//  ZZSliderImageView.swift
//  ZZSlider
//
//  Created by Masoud Sheikh Hosseini on 12/06/2020.
//  Copyright (c) 2020 zzmasoud. All rights reserved.
//

import UIKit

class ZZSliderImageView: UIImageView {
    
    var configs: ZZSliderConfigs.ImageView! {
        didSet {
            self.clipsToBounds = true
            self.contentMode = configs.contentMode
            self.backgroundColor = configs.emptyBackgroundColor
            self.layer.cornerRadius = configs.cornerRadius
            switch configs.textBackgroundStyle {
            case .solid(let color):
                gradientView.backgroundColor = color
                if let gradientLayer = self.gradientLayer {
                    gradientLayer.removeFromSuperlayer()
                    self.gradientLayer = nil
                }
            case .gradient(let colors):
                gradientView.backgroundColor = .clear
                if let gradientLayer = self.gradientLayer {
                    layoutIfNeeded()
                    gradientLayer.colors = colors.map({$0.cgColor})
                } else {
                    let newLayer = _gradientLayer
                    newLayer.colors = colors.map({$0.cgColor})
                    self.gradientView.layer.insertSublayer(newLayer, at: 0)
                    self.gradientLayer = newLayer
                }
            }
            titleLabel.font = configs.font
            titleLabel.textColor = configs.textColor
        }
    }
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            view.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 0),
        ])
        return view
    }()
    
    private var _gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        captionStackView.addArrangedSubview(view)
        return view
    }()
    
    private lazy var captionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        gradientView.addSubview(view)
        view.snapToSuperview(inset: UIEdgeInsets(top: 10, left: 16, bottom: -10, right: -16))
        return view
    }()
    
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setupUI()
    }
    
    private func setupUI() {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = self.gradientLayer {
            gradientLayer.frame.size = gradientView.frame.size
            gradientLayer.removeAllAnimations()
        }
    }
    
    func set(item: ZZSliderItem) {
        item.load { (image) in
            self.image = image
            self.animate(text: item.text, withDuration: self.configs.slideDuration)
        }
    }
    
    private func animate(text: String?, withDuration duration: TimeInterval) {
        guard let text = text else { return }
        let fadeDuration = min(0.7, duration * 0.2)
        let delay = duration - fadeDuration*2
        
        self.titleLabel.text = text
        UIView.animate(withDuration: fadeDuration, animations: {
            self.titleLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: fadeDuration, delay: delay, animations: {
                self.titleLabel.alpha = 0
            }, completion: nil)
        })
    }
}
