//
//  User.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 07.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import ObjectMapper

var vkgroups = [Group]()
var friends : Dictionary<Character, [User]> = [
    "B" : [User(name: "Barbara Millicent", photos: [UIImage(named: "barbi4")!, UIImage(named: "barbi2")!])],
    "M" : [User(name: "Margaret Roberts", photos: [UIImage(named: "barbi1")!, UIImage(named: "barbi8")!])],
    "L" : [User(name: "Lillian Fairchild", photos: [UIImage(named: "barbi2")!, UIImage(named: "barbi1")!])],
    "S" : [User(name: "Skipper", photos: [UIImage(named: "barbi9")!, UIImage(named: "barbi7")!])],
    "K" : [User(name: "Kelly", photos: [UIImage(named: "barbi5")!, UIImage(named: "barbi4")!])],
    "T" : [User(name: "Tutti", photos: [UIImage(named: "barbi6")!, UIImage(named: "barbi6")!])]
]

class User: Mappable {
    var name = ""
    var photos = [UIImage]()
    var id = 0
    var phone = ""
    var photo_50 = ""
    var first_name = ""
    var last_name = ""

    init() {
    }
    
    init(name: String, photos: [UIImage]) {
        self.name = name
        self.photos = photos
    }

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        photos.append(UIImage(named: "barbi3")!)
        id <- map["id"]
        phone <- map["phone"]
        photo_50 <- map["photo_50"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        
        name = first_name + " " + last_name
        loadPhoto()
    }
    
    func loadPhoto(){
        let url = URL(string: photo_50)
        print("loadPhoto>", url)
        ImageCache.default.loadImage(atUrl: url!, completion: { (urlString, image) in
            print("loadImage>", urlString)
                self.photos.removeAll()
                self.photos.append(image!)
        })
    }
}
