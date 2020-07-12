//
//  Profile.swift
//  InterfaceDesignVK_1
//
//  Created by АErmine Harutynyan on 09.07.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//
import Foundation
import ObjectMapper

class Profile: Mappable {
    var online = 0
    var last_name = ""
    var photo_50 = ""
    var first_name = ""
    var id = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        online <- map["online"]
        last_name <- map["last_name"]
        photo_50 <- map["photo_50"]
        id <- map["id"]
        first_name <- map["first_name"]
    }
}
