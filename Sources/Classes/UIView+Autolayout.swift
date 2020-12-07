//
//  UIView+Autolayout.swift
//  ZZSlider
//
//  Created by Masoud Sheikh Hosseini on 12/06/2020.
//  Copyright (c) 2020 zzmasoud. All rights reserved.
//

import UIKit

extension UIView {
     
    func snapToSuperview(inset: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSuperviewConstraint(constraint: topAnchor.constraint(equalTo: (superview?.topAnchor)!, constant: inset.top))
        addSuperviewConstraint(constraint: leadingAnchor.constraint(equalTo: (superview?.leadingAnchor)!, constant: inset.left))
        addSuperviewConstraint(constraint: bottomAnchor.constraint(equalTo: (superview?.bottomAnchor)!, constant: inset.bottom))
        addSuperviewConstraint(constraint: trailingAnchor.constraint(equalTo: (superview?.trailingAnchor)!, constant: inset.right))
    }

    func snapToSuperview(attribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0.0) {
        addSuperviewConstraint(constraint: NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: superview, attribute: attribute, multiplier: 1.0, constant: constant))
    }
    
    func addSuperviewConstraint(constraint: NSLayoutConstraint) {
        superview?.addConstraint(constraint)
    }
}
