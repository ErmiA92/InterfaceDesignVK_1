//
//  DataService.swift
//  InterfaceDesignVK_1
//
//  Created by Ахмед Фокичев on 06.07.2020.
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
                let response = json["response"]
                let news = self.parsNews(response: response)
                completion(true, news, "")
            } else {
                completion(false, [News](), "ошибка")
            }
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
