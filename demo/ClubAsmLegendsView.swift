//
//  ClubAsmLegendsView.swift
//  demo
//
//  Created by Johan Halin on 27/03/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmLegendsView: UIView, ClubAsmActions {
    private let imageCount = 8
    
    private let mainImage: UIImageView
    
    private var images = [UIImageView]()
    private var distance = CGFloat(0)
    
    override init(frame: CGRect) {
        guard let image = UIImage(named: "clubasmlegends")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) else { abort() }
        
        self.mainImage = UIImageView(image: image)
        
        super.init(frame: frame)
        
        self.distance = frame.size.width - image.size.width
        
        self.backgroundColor = .darkGray
        
        self.mainImage.frame = CGRect(
            x: 0,
            y: (self.bounds.size.height / 2.0) - (image.size.height / 2.0),
            width: image.size.width,
            height: image.size.height
        )
        self.mainImage.tintColor = .white
        addSubview(self.mainImage)
        
        for i in 0..<self.imageCount {
            let imageView = UIImageView(image: image)
            imageView.frame = self.mainImage.frame
            imageView.isHidden = true
            imageView.tintColor = UIColor(white: 1.0 - (CGFloat(i) / CGFloat(self.imageCount - 1)), alpha: 1)
            addSubview(imageView)
            sendSubviewToBack(imageView)
            
            self.images.append(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func action1() {
        self.mainImage.isHidden = false
        self.mainImage.frame.origin.x = 0

        for view in self.images {
            view.isHidden = true
            view.frame = self.mainImage.frame
        }
    }
    
    func action2() {
        self.mainImage.frame.origin.x = self.distance * (1.0 / 3.0)
    }
    
    func action3() {
        self.mainImage.frame.origin.x = self.distance * (2.0 / 3.0)
    }
    
    func action4() {
        self.mainImage.frame.origin.x = self.distance * (3.0 / 3.0)
    }
    
    func action5() {
        self.mainImage.isHidden = true
        
        for (index, view) in self.images.enumerated() {
            view.isHidden = false
            
            let ratio = CGFloat(index) / CGFloat(self.imageCount - 1)
            
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
                view.frame.origin.x = self.distance * ratio
            }, completion: nil)
        }
    }
}
