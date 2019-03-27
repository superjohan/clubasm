//
//  ShadeTwist.swift
//  demo
//
//  Created by Johan Halin on 25/03/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmShadeTwistView: UIView, ClubAsmActions {
    private let duration = 1.5
    
    private var shades = [ShadeViewHolder]()
    private var isAnimating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
        
        let width = CGFloat(299) // FIXME: this should come from the image's dimensions
        let height = frame.size.height / 4.0
        let offset = width / 4.0
        
        for i in 0..<4 {
            let centerOffset = -(width / 2.5) + (CGFloat(i) * offset)
            
            let holder = ShadeViewHolder(
                centerX: (frame.size.width / 2.0) + centerOffset,
                y: height * (CGFloat(i)),
                width: width,
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
    
    func action1() {
        if self.isAnimating {
            return
        }
        
        hideAllViews()
        showView(index: 0)
    }
    
    func action2() {
        if self.isAnimating {
            return
        }
        
        hideAllViews()
        showView(index: 1)
    }
    
    func action3() {
        if self.isAnimating {
            return
        }
        
        hideAllViews()
        showView(index: 2)
    }
    
    func action4() {
        if self.isAnimating {
            return
        }
        
        hideAllViews()
        showView(index: 3)
    }
    
    func action5() {
        if self.isAnimating {
            return
        }
        
        animate()

        self.isAnimating = true
    }
    
    private func showView(index: Int) {
        let holder = self.shades[index]

        holder.setViewVisibility(isHidden: false)
    }
    
    private func hideAllViews() {
        for holder in self.shades {
            holder.setViewVisibility(isHidden: true)
        }
    }
    
    private func animate() {
        for holder in self.shades {
            holder.setViewVisibility(isHidden: false)
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

            self.rightView.frame.origin.x = self.x + self.width
            
            self.leftShadeLeft.alpha = 0
            self.leftShadeRight.alpha = 0
            self.rightShadeLeft.alpha = 0
            self.rightShadeRight.alpha = 1
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
        
        func setViewVisibility(isHidden: Bool) {
            self.leftView.isHidden = isHidden
            self.rightView.isHidden = isHidden
            
            if isHidden {
                self.leftView.alpha = 0
                self.rightView.alpha = 0
            } else {
                self.leftView.alpha = 1
                self.rightView.alpha = 1
            }
        }
    }
}