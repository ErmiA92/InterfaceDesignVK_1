//
//  IBTesto.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 05.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class IBTesto: UIView {
    
    @IBInspectable var radius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = radius
            
        }
    }
    
}
