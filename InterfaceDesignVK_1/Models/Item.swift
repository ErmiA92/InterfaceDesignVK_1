//
//  Item.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 09.07.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable {
    var post_id = ""
    var can_repost = ""
    var can_comment = 0
    var id = ""
    var type = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        post_id <- map["post_id"]
        can_repost <- map["can_repost"]
        can_comment <- map["can_comment"]
        id <- map["id"]
        type <- map["type"]
    }
}
