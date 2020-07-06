//
//  RealmUser.swift
//  InterfaceDesignVK_1
//
//  Created by Ахмед Фокичев on 02.04.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var name = ""
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var photo_50 = ""
}
