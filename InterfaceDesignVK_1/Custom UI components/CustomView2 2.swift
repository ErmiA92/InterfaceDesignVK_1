//
//  CustomView2.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 30.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class CustomView2: UIView {

    override func draw(_ rect: CGRect) {
           super.draw(rect)
        
    guard let context = UIGraphicsGetCurrentContext() else { return }
           
           let stroke = UIColor.black
           context.setStrokeColor(stroke.cgColor)
           
           
           context.strokeEllipse(in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
    
     }
}
