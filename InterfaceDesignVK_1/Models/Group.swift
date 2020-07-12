//
//  Group.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 09.07.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import ObjectMapper

class Groupe: Mappable {
    var screen_name = ""
    var type = ""
    var photo_50 = ""
    var name = ""
    var id = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        screen_name <- map["screen_name"]
        type <- map["type"]
        photo_50 <- map["photo_50"]
        id <- map["id"]
        name <- map["name"]
    }
}
