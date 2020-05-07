//
//  Groups.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 02.04.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Group: Mappable {
    
     var id = 0
     var name = ""
     var description = ""
     var image = UIImage(named: "barbi3")
     var imageUrl = ""
        
        init() {
        }
        
        init(text: String, image: UIImage, views: Int) {
            self.description = text
            self.image = image
        }
        init(text: String, imageUrl: String, views: Int) {
             self.description = text
             self.imageUrl = imageUrl
            loadPhoto()
         }
        
        func loadPhoto(){
            if let url = URL(string: imageUrl) {
              ImageCache.default.loadImage(atUrl: url, completion: { (urlString, image) in
                  print("loadImage>", urlString)
                      self.image = image
              })
            }
          }
        
        required convenience init?(map: Map) {
            self.init()
        }
        
        func mapping(map: Map) {
            description <- map["description"]
            name <- map["name"]
            imageUrl <- map["photo_50"]
            id <- map["id"]
        }
    }
