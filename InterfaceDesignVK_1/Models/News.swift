//
//  News.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 12.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import SwiftyImageCache

class News: Mappable {
    
    var text = ""
    var image = UIImage(named: "barbi3")
    var views = 0
    var imageUrl = ""
    
    init() {
    }
    
    init(text: String, image: UIImage, views: Int) {
        self.text = text
        self.views = views
        self.image = image
    }
    init(text: String, imageUrl: String, views: Int) {
         self.text = text
         self.views = views
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
        text <- map["text"]
        //    phone <- map["phone"]
        //    photo_50 <- map["photo_50"]
        //    first_name <- map["first_name"]
        //    last_name <- map["last_name"]
        //
        //    name = first_name + " " + last_name
        //    loadPhoto()
    }
}




