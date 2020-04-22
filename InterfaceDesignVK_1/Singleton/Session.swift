//
//  Session.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 20.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation

class Session {
    static let instance: Session = Session()
    
    var token: String = "0952aa9dc84b0a07fe8df167a89032fc7936daba75b4fb0b265cdfd90eab610618e2dfe8fe0eca2625a1a"
    var userID: Int = 293104687
    
    private init() {}
}


