//
//  RealmGroups.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Arutiunian on 14.04.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import RealmSwift

class ReaLmGroup: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var text = ""
    @objc dynamic var imageUrl = ""    
}
