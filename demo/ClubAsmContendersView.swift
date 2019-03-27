//
//  ClubAsmContendersView.swift
//  demo
//
//  Created by Johan Halin on 27/03/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmContendersView: UIView, ClubAsmActions {
    private let imageCount = 10
    private let contendersFilled: UIImageView
    
    private var boxParts = [UIImageView]()
    private var outlines = [UIImageView]()
    
    override init(frame: CGRect) {
        guard let filledImage = UIImage(named: "clubasmcontendersfilled") else { abort() }
        
        self.contendersFilled = UIImageView(image: filledImage)

        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        self.contendersFilled.frame = CGRect(
            x: (self.bounds.size.width / 2.0) - (filledImage.size.width / 2.0),
            y: (self.bounds.size.height / 2.0) - (filledImage.size.height / 2.0),
            width: filledImage.size.width,
            height: filledImage.size.height
        )
        addSubview(self.contendersFilled)
        
        for i in 1...4 {
            let imageView = UIImageView(image: UIImage(named: "clubasmcontendersbox\(i)"))
            imageView.frame = self.contendersFilled.frame
            imageView.isHidden = true
            addSubview(imageView)
            
            self.boxParts.append(imageView)
        }

        guard let outlineImage = UIImage(named: "clubasmcontendersoutline") else { return }

        for _ in 0..<self.imageCount {
            let imageView = UIImageView(image: outlineImage)
            imageView.frame = self.contendersFilled.frame
            imageView.isHidden = true
            addSubview(imageView)
            
            self.outlines.append(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func action1() {
        for view in self.boxParts {
            view.isHidden = true
        }
        
        for view in self.outlines {
            view.isHidden = true
            view.transform = CGAffineTransform.identity
        }
        
        self.contendersFilled.isHidden = false
        
        self.boxParts[0].isHidden = false
    }
    
    func action2() {
        self.boxParts[1].isHidden = false
    }
    
    func action3() {
        self.boxParts[2].isHidden = false
    }
    
    func action4() {
        self.boxParts[3].isHidden = false
    }
    
    func action5() {
        self.contendersFilled.isHidden = true
        
        for (index, view) in self.outlines.enumerated() {
            view.isHidden = false
            let scale = CGFloat(index + 1) * 0.1
            
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
                view.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            }, completion: nil)
        }
    }
}
