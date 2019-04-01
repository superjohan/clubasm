//
//  ClubAsmGamingView.swift
//  demo
//
//  Created by Johan Halin on 01/04/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmGamingView: UIView, ClubAsmActions {
    private let maskCount = 10
    
    private var images = [UIImageView]()
    
    private let container = UIView()
    private let maskAnimationView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
    
        self.container.frame = self.bounds
        addSubview(self.container)

        for i in 1...5 {
            let image = UIImage(named: "clubasmgaming\(i)")
            let imageView = UIImageView(image: image)
            imageView.frame = self.bounds
            imageView.isHidden = true
            self.container.addSubview(imageView)
            
            self.images.append(imageView)
        }

        for i in 0..<self.maskCount {
            let height = self.bounds.size.height / CGFloat(self.maskCount)
            let mask = UIView(frame:
                CGRect(
                    x: 0,
                    y: height * CGFloat(i),
                    width: self.bounds.size.width,
                    height: height
                )
            )
            mask.backgroundColor = .white
            
            self.maskAnimationView.addSubview(mask)
        }
        
        self.container.mask = self.maskAnimationView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func action1() {
        for view in self.images {
            view.isHidden = true
        }
        
        for (index, view) in self.maskAnimationView.subviews.enumerated() {
            view.frame.origin.y = CGFloat(index) * view.bounds.size.height
            view.layer.removeAllAnimations()
        }

        animate(index: 0)
    }
    
    func action2() {
        animate(index: 1)
    }
    
    func action3() {
        animate(index: 2)
    }
    
    func action4() {
        animate(index: 3)
    }
    
    func action5() {
        for view in self.images {
            view.alpha = 1
            view.isHidden = false
        }

        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
            for (index, view) in self.maskAnimationView.subviews.shuffled().enumerated() {
                let offset = index % 2 == 0 ? view.bounds.size.height : -view.bounds.size.height
                view.frame.origin.y = CGFloat(index) * view.bounds.size.height + offset
            }
        }, completion: nil)
    }
    
    private func animate(index: Int) {
        self.images[index].isHidden = false
        self.images[index].alpha = 1
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            self.images[index].alpha = 0
        }, completion: nil)
    }
}
