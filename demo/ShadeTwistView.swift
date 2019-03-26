//
//  ShadeTwist.swift
//  demo
//
//  Created by Johan Halin on 25/03/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ShadeTwistView: UIView {
    private let duration = 1.5
    
    private var shades = [ShadeViewHolder]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
        
        let height = frame.size.height / 4.0
        
        for i in 0..<4 {
            let holder = ShadeViewHolder(
                centerX: frame.size.width / 2.0,
                y: height * (CGFloat(i)),
                width: 299,
                height: height,
                startDelay: TimeInterval(i) * (self.duration / 4.0)
            )
            
            self.shades.append(holder)
            
            addSubview(holder.leftView)
            addSubview(holder.rightView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        for holder in self.shades {
            holder.animateRow(duration: self.duration)
        }
    }
    
    private class ShadeViewHolder {
        let leftView = UIImageView(image: UIImage(named: "clubasmrivalsblack"))
        private let leftShadeLeft = UIImageView(image: UIImage(named: "clubasmshadeleft"))
        private let leftShadeRight = UIImageView(image: UIImage(named: "clubasmshaderight"))
        let rightView = UIImageView(image: UIImage(named: "clubasmrivalswhite"))
        private let rightShadeLeft = UIImageView(image: UIImage(named: "clubasmshadeleft"))
        private let rightShadeRight = UIImageView(image: UIImage(named: "clubasmshaderight"))
        
        let startDelay: TimeInterval
        let width: CGFloat
        let x: CGFloat
        
        var started = false
        
        init(centerX: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, startDelay: TimeInterval) {
            self.startDelay = startDelay
            
            self.leftView.backgroundColor = .white
            self.rightView.backgroundColor = .black
            
            self.leftView.frame = CGRect(
                x: centerX - width / 2,
                y: y,
                width: width,
                height: height
            )
            self.rightView.frame = CGRect(
                x: centerX + width / 2,
                y: y,
                width: 0,
                height: height
            )
            
            self.x = self.leftView.frame.origin.x
            self.width = width
            
            self.leftView.addSubview(self.leftShadeLeft)
            self.leftView.addSubview(self.leftShadeRight)
            self.rightView.addSubview(self.rightShadeLeft)
            self.rightView.addSubview(self.rightShadeRight)
            
            self.leftShadeLeft.frame = self.leftView.bounds
            self.leftShadeRight.frame = self.leftView.bounds
            self.rightShadeLeft.frame = self.rightView.bounds
            self.rightShadeRight.frame = self.rightView.bounds
            
            self.leftShadeLeft.autoresizingMask = [.flexibleWidth]
            self.leftShadeRight.autoresizingMask = self.leftShadeLeft.autoresizingMask
            self.rightShadeLeft.autoresizingMask = self.leftShadeLeft.autoresizingMask
            self.rightShadeRight.autoresizingMask = self.leftShadeLeft.autoresizingMask
        }
        
        func animateRow(duration: TimeInterval) {
            self.rightView.frame.origin.x = self.x + self.width
            
            self.leftShadeLeft.alpha = 0
            self.leftShadeRight.alpha = 0
            self.rightShadeLeft.alpha = 0
            self.rightShadeRight.alpha = 1
            
            let delay = self.started ? 0 : self.startDelay
            
            self.started = true
            
            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut], animations: {
                self.leftView.frame.size.width = 0
                self.leftShadeLeft.alpha = 1
                
                self.rightView.frame.origin.x = self.x
                self.rightView.frame.size.width = self.width
                self.rightShadeRight.alpha = 0
            }, completion: { _ in
                self.leftView.frame.origin.x = self.x + self.width
                self.leftShadeLeft.alpha = 0
                self.leftShadeRight.alpha = 1
                
                self.rightShadeLeft.alpha = 0
                self.rightShadeRight.alpha = 0
                
                UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
                    self.leftView.frame.origin.x = self.x
                    self.leftView.frame.size.width = self.width
                    self.leftShadeRight.alpha = 0
                    
                    self.rightView.frame.size.width = 0
                    self.rightShadeLeft.alpha = 1
                }, completion: { _ in
                    self.animateRow(duration: duration)
                })
            })
        }
    }
}
