//
//  RealmNews.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 15.04.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//
import Foundation
import RealmSwift

class RealmNews: Object {
    @objc dynamic var views = 0
    @objc dynamic var text = ""
    @objc dynamic var imageUrl = ""
}
