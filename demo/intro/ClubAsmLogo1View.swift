//
//  ClubAsmLogo1View.swift
//  demo
//
//  Created by Johan Halin on 13/04/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmLogo1View: UIView, ClubAsmActions {
    let upperViews: [UIImageView]
    let lowerViews: [UIImageView]
    
    override init(frame: CGRect) {
        var upperViews = [UIImageView]()
        var lowerViews = [UIImageView]()
        
        let image1 = UIImage(named: "clubasmlogo1-c")!
        let image2 = UIImage(named: "clubasmlogo1-l")!
        let image3 = UIImage(named: "clubasmlogo1-u")!
        let image4 = UIImage(named: "clubasmlogo1-b")!
        let imageView1 = UIImageView(image: image1)
        let imageView2 = UIImageView(image: image2)
        let imageView3 = UIImageView(image: image3)
        let imageView4 = UIImageView(image: image4)
        upperViews.append(imageView1)
        upperViews.append(imageView2)
        upperViews.append(imageView3)
        upperViews.append(imageView4)

        let image5 = UIImage(named: "clubasmlogo1-a")!
        let image6 = UIImage(named: "clubasmlogo1-s")!
        let image7 = UIImage(named: "clubasmlogo1-m")!
        let imageView5 = UIImageView(image: image5)
        let imageView6 = UIImageView(image: image6)
        let imageView7 = UIImageView(image: image7)
        lowerViews.append(imageView5)
        lowerViews.append(imageView6)
        lowerViews.append(imageView7)

        self.upperViews = upperViews
        self.lowerViews = lowerViews
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        let x = (self.bounds.size.width / 2.0) - (image1.size.width / 2.0)
        let height = image1.size.height + image5.size.height
        let upperY = (self.bounds.size.height / 2.0) - (height / 2.0)
        
        for (index, view) in self.upperViews.enumerated() {
            view.frame = CGRect(
                x: x,
                y: upperY,
                width: image1.size.width,
                height: image1.size.height
            )
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 10.0
            view.layer.shadowOpacity = 0.5
            
            switch index {
            case 0:
                view.layer.shadowColor = UIColor.black.cgColor
            case 1:
                view.layer.shadowColor = UIColor.black.cgColor
            case 2:
                view.layer.shadowColor = UIColor.black.cgColor
            case 3:
                view.layer.shadowColor = UIColor.black.cgColor
            default:
                abort()
            }

            addSubview(view)
        }
        
        let lowerY = upperY + image1.size.height
        
        for view in self.lowerViews {
            view.layer.anchorPoint.y = 0
            view.frame = CGRect(
                x: x,
                y: lowerY,
                width: image5.size.width,
                height: image5.size.height
            )
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 10.0
            view.layer.shadowOpacity = 0.5
            view.layer.shadowColor = UIColor.black.cgColor
            addSubview(view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func action1() {
        for view in self.upperViews {
            view.isHidden = true
        }
        
        for view in self.lowerViews {
            view.layer.transform = CATransform3DIdentity
            view.layer.transform.m34 = -0.002
            view.isHidden = true
        }
        
        self.upperViews[0].isHidden = false
    }
    
    func action2() {
        self.upperViews[1].isHidden = false
    }
    
    func action3() {
        self.upperViews[2].isHidden = false
    }
    
    func action4() {
        self.upperViews[3].isHidden = false
    }
    
    func action5() {
        for (index, view) in self.lowerViews.enumerated() {
            view.isHidden = false
            
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat.pi / 2.0, 1, 0, 0)
            
            UIView.animate(withDuration: 1, delay: Double(index) * 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [.curveEaseOut], animations: {
                view.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
}
