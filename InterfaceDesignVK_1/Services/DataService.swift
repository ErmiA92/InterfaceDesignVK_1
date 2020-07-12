//
//  DataService.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 06.07.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class DataService {
    static let shared = DataService()
    var url = "https://api.vk.com/method/"
    var version = "5.103"
    var client_id = 7342462
    
    
    func vkRequestNewsGet( completion: @escaping (_ success: Bool,[News], _ error: String) -> Void) {
        let url_suff = "newsfeed.get/"
        var params = Parameters()
        params["access_token"] = Session.instance.token
        params["v"] = version
        params["count"] = 30
        params["source_ids"] = "pages"
        print("Session.instance.token>", Session.instance.token)
        Alamofire.request( url + url_suff, method: .get, parameters: params ).responseJSON { response in
            if let statusCode = response.response?.statusCode, statusCode == 200 {
                
                
                let json = JSON(response.value)
                print("vkRequestNewsGet>json>", json)
                let response = json["response"]
                
                self.parsAll(value: response)
                
                               
                              
                //let news = self.parsNews(response: response)
                
                
                completion(true, [News](), "")
            } else {
                completion(false, [News](), "ошибка")
            }
        }
    }
    
    func parsProfiles(response: JSON) -> [Profile] {
        if let list = Mapper<Profile>().mapArray(JSONObject: response.object) {
            return list
        } else {
            return [Profile]()
        }
    }
    
    func parsGroups(response: JSON) -> [Groupe] {
        if let list = Mapper<Groupe>().mapArray(JSONObject: response.object) {
            return list
        } else {
            return [Groupe]()
        }
    }
    func parsItems(response: JSON) -> [Item] {
        if let list = Mapper<Item>().mapArray(JSONObject: response.object) {
            return list
        } else {
            return [Item]()
        }
    }
    
    
    func parsAll(value:JSON) {
        
        let dispatchGroup = DispatchGroup()
        
        var profiles = [Profile]()
        var groups = [Groupe]()
        var items = [Item]()
        
        DispatchQueue.global().async(group: dispatchGroup) {
            profiles = self.parsProfiles(response: value["profiles"])
        }
        DispatchQueue.global().async(group: dispatchGroup) {
            groups = self.parsGroups(response: value["groups"])
        }
        DispatchQueue.global().async(group: dispatchGroup) {
            items = self.parsItems(response: value["items"])
        }
        /////////
        /////////
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("dispatchGroup>notify")
            print("profiles.count>",profiles.count)
            print("groups.count>",groups.count)
            print("items.count>",items.count)
        }
        
    }
    
    
    
    func parsNews(response: JSON) -> [News] {
        print("parsNews>", response)
        
        var newsList = [News]()
        
        //DispatchQueue.main.async {
            var news = [News]()
            for (_,value) in response["items"]{
                let text = value["text"].stringValue
                let id = value["id"].intValue
                let attachments = value["attachments"]
                print("attachments>",attachments)
                let photos = attachments[0]["photo"]["sizes"]
                // print("photos>",photos)
                var imageUrl = ""
                for (_,img) in photos {
                    if imageUrl.isEmpty {
                        imageUrl = img["url"].stringValue
                    }
                }
                news.append(News(text: text, imageUrl: imageUrl, views: id))
            }
            
        return news
//           DispatchQueue.main.sync {
//                newsList = news
//                return newsList
//           }
//        }
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//            self.tableView.reloadData()
//        }
        
//        print("parsUsers>friends.count>",news.count)
//        for new in news {
//            let realmNews = RealmNews()
//
//            realmNews.text =  new.text
//            realmNews.imageUrl =   new.imageUrl
//            realmNews.views =   new.views
//
//            try! realm.write {
//                realm.add(realmNews)
//            }
//        }
    }
    
    
}
