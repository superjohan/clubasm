//
//  ClubAsmCubeView.swift
//  demo
//
//  Created by Johan Halin on 03/04/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmDefeatView: UIView, ClubAsmActions {
    private let imageView: UIImageView

    private var views = [UIView]()
    
    override init(frame: CGRect) {
        guard let image = UIImage(named: "clubasmdefeat") else { abort() }
        
        self.imageView = UIImageView(image: image)
        
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        self.imageView.frame = CGRect(
            x: (self.bounds.size.width / 2.0) - (image.size.width / 2.0),
            y: (self.bounds.size.height / 2.0) - (image.size.height / 2.0),
            width: image.size.width,
            height: image.size.height
        )
        
        for i in 0..<4 {
            let view = UIView(frame: self.imageView.frame)
            view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
            view.layer.transform.m34 = -0.002
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat.pi * (CGFloat(i) * 0.25), 0, 1, 0)
            view.layer.zPosition = -image.size.width
            view.isHidden = true
            addSubview(view)

            self.views.append(view)
        }
        
        self.imageView.layer.zPosition = image.size.width
        self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        self.imageView.isHidden = true
        
        addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var animating = false
    
    func action1() {
        self.views[1].isHidden = true
        self.views[2].isHidden = false
    }
    
    func action2() {
        self.views[2].isHidden = true
        self.views[3].isHidden = false
    }
    
    func action3() {
        self.views[3].isHidden = true
        self.views[0].isHidden = false
    }
    
    func action4() {
        self.views[0].isHidden = true
        self.views[1].isHidden = false
    }
    
    func action5() {
        for view in self.views {
            view.isHidden = false
        }
        
        if self.animating { return }
        
        for (index, view) in self.views.enumerated() {
            view.isHidden = false
            
            let sign: Double = index > 2 ? -1 : 1
            let animation2 = CABasicAnimation(keyPath: "transform.rotation.y")
            animation2.byValue = NSNumber(floatLiteral: Double.pi * 2 * sign)
            animation2.duration = 10
            animation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation2.repeatCount = Float.infinity
            view.layer.add(animation2, forKey: "yrotation")
        }
        
        self.imageView.isHidden = false
        
        UIView.animate(withDuration: 4, delay: 0, options: [.curveEaseOut], animations: {
            self.imageView.transform = self.imageView.transform.scaledBy(x: 0.75, y: 0.75)
            self.imageView.alpha = 0.5
        }, completion: nil)

        self.animating = true
    }
}
