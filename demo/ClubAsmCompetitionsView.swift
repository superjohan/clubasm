//
//  ClubAsmCompetitionsView.swift
//  demo
//
//  Created by Johan Halin on 29/03/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmCompetitionsView: UIView, ClubAsmActions {
    private let duration = TimeInterval(0.2)
    
    private var images = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backgroundColor = UIColor.darkGray
        
        self.backgroundColor = backgroundColor
        
        guard let image = UIImage(named: "clubasmcompetitions")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate) else { return }
        
        for i in 0..<4 {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(
                x: 0,
                y: CGFloat(i) * image.size.height,
                width: image.size.width,
                height: image.size.height
            )
            addSubview(imageView)
            
            self.images.append(imageView)
            
            switch i {
            case 0:
                imageView.tintColor = .black
            case 1:
                imageView.tintColor = backgroundColor
                imageView.backgroundColor = .white
            case 2:
                imageView.tintColor = .white
            case 3:
                imageView.tintColor = .gray
                imageView.backgroundColor = .black
            default:
                abort()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func action1() {
        for (index, view) in self.images.enumerated() {
            view.frame.origin.x = index % 2 == 0 ? -self.images[0].bounds.size.width : self.bounds.size.width
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat.pi, 1, 0, 0)
        }
        
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseOut], animations: {
            self.images[0].frame.origin.x = (self.bounds.size.width / 2.0) - (self.images[0].bounds.size.width / 2.0)
        }, completion: nil)
    }
    
    func action2() {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseOut], animations: {
            self.images[1].frame.origin.x = (self.bounds.size.width / 2.0) - (self.images[1].bounds.size.width / 2.0)
        }, completion: nil)
    }
    
    func action3() {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseOut], animations: {
            self.images[2].frame.origin.x = (self.bounds.size.width / 2.0) - (self.images[2].bounds.size.width / 2.0)
        }, completion: nil)
    }
    
    func action4() {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseOut], animations: {
            self.images[3].frame.origin.x = (self.bounds.size.width / 2.0) - (self.images[3].bounds.size.width / 2.0)
        }, completion: { done in
            for (index, view) in self.images.enumerated() {
                UIView.animate(withDuration: self.duration * 3, delay: TimeInterval(index) * (self.duration / 2.0), options: [.curveEaseOut], animations: {
                    view.layer.transform = CATransform3DIdentity
                }, completion: nil)
            }
        })
    }
    
    func action5() {
    }
}
