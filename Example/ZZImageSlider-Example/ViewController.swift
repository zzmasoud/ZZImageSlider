//
//  ViewController.swift
//  ZZImageSlider-Example
//
//  Created by Masoud Sheikh Hosseini on 12/06/20.
//  Copyright (c) 2020 zzmasoud. All rights reserved.
//

import UIKit
import ZZImageSlider

class ViewController: UIViewController {
    
    @IBOutlet private weak var vSlider: ZZImageSlider!
    @IBOutlet private weak var hSlider: ZZImageSlider!
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        vSlider.alpha = sender.isOn ? 1 : 0
        hSlider.alpha = sender.isOn ? 0 : 1
        
        vSlider.delegate = sender.isOn ? self : nil
        hSlider.delegate = sender.isOn ? nil : self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.21, green:0.21, blue:0.23, alpha:1.00)
        vSlider.alpha = 1        
        hSlider.alpha = 0
        
        let items: [ZZSliderItem] =
            [
                UIImageSliderItem(image: UIImage(named: "1.jpg")!, text: "Gorgan\nby Asal Lotfi"),
                BundleSliderItem(imageName: "2.jpg", text: "Astara\nby Moeen Zamani"),
                BundleSliderItem(imageName: "3.jpg", text: "Karaj\nby Majid Hajiloo"),
                BundleSliderItem(imageName: "4.jpg", text: "Yazd\nby Hasan Almasi"),
                BundleSliderItem(imageName: "5.jpg", text: "Persian Tea\nby Mehrshad Rajabi"),
            ]
        
        hSlider.items = items
        vSlider.items = items
        
        let verticalConfs: ZZSliderConfigs = {
            var confs = ZZSliderConfigs()
            confs.sliderAxis = .vertical
            confs.items.edgeInsets = .zero
            confs.items.edgeInsets.top = 16
            confs.items.edgeInsets.bottom = -16
            confs.items.edgeInsets.left = 8
            confs.items.cornerRadius = 10
            confs.items.sizePercent = 0.1
            confs.items.selectionStyle = .none
            confs.imageView.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            confs.imageView.textBackgroundStyle = .gradient(colors: [
                UIColor.black.withAlphaComponent(0),
                UIColor.black.withAlphaComponent(0.67)
            ])
            return confs
        }()
        vSlider.configs = verticalConfs
        
        let hConfs: ZZSliderConfigs = {
            var confs = ZZSliderConfigs()
            confs.sliderAxis = .horizontal
            confs.items.edgeInsets.left = 16
            confs.items.edgeInsets.right = -16
            confs.items.cornerRadius = 20
            confs.items.sizePercent = 0.1
            confs.items.selectionStyle = .none
            confs.imageView.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            confs.imageView.textBackgroundStyle = .gradient(colors: [
                UIColor.black.withAlphaComponent(0),
                UIColor.black.withAlphaComponent(0.7)
            ])
            return confs
        }()
        hSlider.configs = hConfs
    }
}


extension ViewController: ZZImageSliderDelegate {
    func didSlideTo(item: ZZSliderItem, index: Int) {
        print("-> ", index)
    }
    
    func didSelectSlide(item: ZZSliderItem, index: Int) {
        print("didSelectSlide: ", index)
    }
}
