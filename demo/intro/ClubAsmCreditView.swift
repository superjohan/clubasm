//
//  ClubAsmCreditView.swift
//  demo
//
//  Created by Johan Halin on 11/04/2019.
//  Copyright © 2019 Dekadence. All rights reserved.
//

import UIKit

class ClubAsmCreditView: UIView, ClubAsmActions {
    private var images = [UIView]()
    private let container = UIView()
    
    private var position = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.container.frame = self.bounds
        self.container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(self.container)
        
        for i in 1...4 {
            for j in 1...5 {
                let image = UIImage(named: "clubasmcredit\(i)-\(j)")!
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageView.frame = self.bounds
                imageView.isHidden = true
                imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.container.addSubview(imageView)
                
                self.images.append(imageView)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func action1() {
        hideViews()
        showNextImage()
    }
    
    func action2() {
        showNextImage()
    }
    
    func action3() {
        showNextImage()
    }
    
    func action4() {
        showNextImage()
    }
    
    func action5() {
        showNextImage()
        
        let delay = ClubAsmConstants.barLength - (ClubAsmConstants.tickLength * 8)
        perform(#selector(hideViews), with: nil, afterDelay: delay)
    }
    
    @objc private func hideViews() {
        for view in self.images {
            view.isHidden = true
        }
    }
    
    private func showNextImage() {
        self.images[self.position].isHidden = false
        self.position += 1
    }
}
