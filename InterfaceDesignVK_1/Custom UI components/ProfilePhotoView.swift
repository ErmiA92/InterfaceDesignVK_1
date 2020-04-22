//
//  customView.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 30.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit

class ProfilePhotoView : UIView {
   
    var imageView: UIImageView = UIImageView()
    var shadowView: UIView = UIView()

    func setShadowView(color: CGColor, opacity: Float) {
        shadowView = UIView(frame: CGRect(origin: CGPoint(), size: frame.size))
        shadowView.layer.cornerRadius = frame.height / 2
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = color
        shadowView.layer.shadowOpacity = opacity
    }

    func setImageView(_ image: UIImage) {
        imageView = UIImageView(frame: CGRect(origin: CGPoint(), size: frame.size))
        imageView.layer.cornerRadius = frame.height / 2
        imageView.image = image
        imageView.clipsToBounds = true
    }

   @objc func animateAvatar() {
    
//    print("Hop hey lalaley")
       let animation = CASpringAnimation(keyPath: "transform.scale")
       animation.fromValue = 0
       animation.toValue = 1
       animation.stiffness = 50
       animation.mass = 1
       animation.duration = 0.70
    
        self.imageView.layer.add(animation, forKey: nil)
        self.shadowView.layer.add(animation, forKey: nil)
    }

    init() { super.init(frame: CGRect()) }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfilePhotoView.animateAvatar))
        self.addGestureRecognizer(tap) //вызов функции
        
        setShadowView(color: UIColor.black.cgColor, opacity: 0.7)
        setImageView(UIImage(named: "barbi2")!)
        addSubview(shadowView)
        shadowView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

