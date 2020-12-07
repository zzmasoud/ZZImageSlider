//
//  ZZImageSlider.swift
//  ZZSlider
//
//  Created by Masoud Sheikh Hosseini on 12/06/2020.
//  Copyright (c) 2020 zzmasoud. All rights reserved.
//

import UIKit

public protocol ZZImageSliderDelegate: class {
    func didSlideTo(item: ZZSliderItem, index: Int)
    func didSelectSlide(item: ZZSliderItem, index: Int)
}

open class ZZImageSlider: UIView {
    
    private let containerStackView: UIStackView = UIStackView()
    private let itemsStackView: UIStackView = UIStackView()
    private let imageView: ZZSliderImageView = ZZSliderImageView()
    
    private lazy var timer: Timer = {
        return Timer.scheduledTimer(timeInterval: configs.slideDuration, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }()
    
    open var items: [ZZSliderItem]?
    
    open var configs: ZZSliderConfigs! = ZZSliderConfigs() {
        didSet {
            applyConfigs()
            imageView.configs = configs.imageView
            guard let items = items else { return }
            add(items: items)
            timer.fire()
        }
    }
    
    open var selectedIndex: Int = -1 {
        didSet {
            guard oldValue != selectedIndex else { return }
            if select(index: selectedIndex, oldIndex: oldValue) {
                delegate?.didSlideTo(item: items![selectedIndex], index: selectedIndex)
            }
        }
    }
    
    public var delegate: ZZImageSliderDelegate?
    
    @objc private func runTimer() {
        if selectedIndex == items!.count - 1 {
            selectedIndex = 0
        } else {
            selectedIndex += 1
        }
    }
    
    @objc private func slideTapAction() {
        guard let item = items?[selectedIndex] else { return }
        delegate?.didSelectSlide(item: item, index: selectedIndex)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        configUI()
    }
    
    private func setupUI() {
        setupContainerStackView()
        setupContainerSubviews()
    }
    
    private func configUI() {
        self.backgroundColor = .clear
        
        itemsStackView.distribution = .fillEqually
        itemsStackView.alignment = .fill
        itemsStackView.axis = .vertical
        
        containerStackView.distribution = .fill
        containerStackView.axis = .horizontal
        containerStackView.alignment = .fill
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(slideTapAction)))
        imageView.isUserInteractionEnabled = true
    }
    
    private func setupContainerStackView() {
        self.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupContainerSubviews() {
        containerStackView.addArrangedSubview(imageView)

        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        containerStackView.addArrangedSubview(emptyView)
        emptyView.addSubview(itemsStackView)
    }
    
    private func add(items: [ZZSliderItem]) {
        itemsStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        
        for (index, item) in items.enumerated() {
            let itemImageView: UIImageView = {
                let view = UIImageView()
                item.load { (image) in
                    view.image = image
                }
                view.backgroundColor = configs.items.emptyBackgroundColor
                view.layer.cornerRadius = configs.items.cornerRadius
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchUpAction(sender:))))
                view.contentMode = .scaleAspectFill
                view.isUserInteractionEnabled = true
                view.clipsToBounds = true
                view.tag = index
                return view
            }()
            itemsStackView.addArrangedSubview(itemImageView)
        }
    }
    
    private func applyConfigs() {
        itemsStackView.spacing = configs.items.spacing
        containerStackView.axis = configs.sliderAxis
        configItemsStack(withAxis: configs.sliderAxis)
    }
    
    private func configItemsStack(withAxis axis: NSLayoutConstraint.Axis) {
        itemsStackView.snapToSuperview(inset: configs.items.edgeInsets)

        switch axis {
        case .vertical:
            itemsStackView.axis = .horizontal
            self.addConstraint(itemsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: configs.items.sizePercent))

        case .horizontal:
            itemsStackView.axis = .vertical
            self.addConstraint(itemsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: configs.items.sizePercent))

        @unknown default:
            break
        }
    }
    
    @objc private func touchUpAction(sender: UIGestureRecognizer) {
        guard let view = sender.view else { return }
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: configs.slideDuration, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        selectedIndex = view.tag
    }
    
    private func select(index: Int, oldIndex: Int) -> Bool {
        guard let item = items?[index] else { return false }
        imageView.set(item: item)
        switch configs.items.selectionStyle {
        case .border(let color, let width):
            let itemView = itemsStackView.arrangedSubviews[index]
            itemView.layer.borderColor = color.cgColor
            itemView.layer.borderWidth = width
            
            guard oldIndex >= 0 else { return true}
            let oldItemView = itemsStackView.arrangedSubviews[oldIndex]
            oldItemView.layer.borderWidth = 0
        default:
            break
        }
        return true
    }
}
