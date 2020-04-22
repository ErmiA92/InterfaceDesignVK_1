//
//  testView.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 30.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class testView: UIView {
    
    override class var layerClass: AnyClass {

        
    testView.layer.shadowColor = UIColor.black
    testView.layer.shadowOpacity = 0.5
    testView.layer.shadowRadius = 8
    testView.layer.shadowOffset = CGSize.zero

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
