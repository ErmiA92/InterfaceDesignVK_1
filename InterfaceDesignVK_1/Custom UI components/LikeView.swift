//
//  LikeView.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 04.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit

class LikeView: UIButton {
    
    var likesAmount: Int = 0
    var isPressed: Bool = false
    var titleString: String = String()
    
    @objc func press() {
        likesAmount += (isPressed ? -1 : 1)
        isPressed = !isPressed
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.backgroundColor = (self.isPressed ? UIColor.black : UIColor.white)
            self.titleString = (self.isPressed ? "❤️" : "🖤") + "  " + String(self.likesAmount)
            self.setTitleColor((self.isPressed ? UIColor.red : UIColor.black), for: .normal)
        })
        setTitle(titleString, for: .normal)
    }
    
    init() {
        super.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.addTarget(self, action: #selector(LikeView.press), for: .touchDown)
        self.setTitleColor((isPressed ? UIColor.red : UIColor.black), for: .normal)
        self.setTitle("🖤  0", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
