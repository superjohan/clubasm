//
//  ClubAsmLearnView.swift
//  demo
//
//  Created by Johan Halin on 02/04/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmLearnView: UIView, ClubAsmActions {
    private var images = [UIImageView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        for _ in 0..<5 {
            guard let image = UIImage(named: "clubasmlearn") else { return }
            let imageView = UIImageView(image: image)
            imageView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            imageView.frame = CGRect(
                x: self.bounds.size.width / 2.0,
                y: (self.bounds.size.height / 2.0) - (image.size.height / 2.0),
                width: image.size.width,
                height: image.size.height
            )
            addSubview(imageView)
            
            self.images.append(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func action1() {
        for view in self.images {
            view.layer.transform = CATransform3DIdentity
            view.layer.transform.m34 = -0.002
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
        animate(index: 4)
    }
    
    private func animate(index: Int) {
        let view = self.images[index]
        let duration = index < 4 ? 0.5 : 1
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat.pi, 0, 1, 0)
        }, completion: nil)
    }
}
