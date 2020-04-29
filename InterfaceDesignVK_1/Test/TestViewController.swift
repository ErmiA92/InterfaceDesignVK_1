//
//  TestViewController.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 04.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SwiftyJSON
import Alamofire
import ObjectMapper
import RealmSwift


class API {

    

    init() {}
    
//    func VKRequestGroupsGet() {
//        var url_suff = "groups.get/"
//        var params = Parameters()
//        params["user_ids"] = Session.instance.userID
//        params["access_token"] = Session.instance.token
//        params["v"] = version
//        params["fields"] = "nickname, country, photo_50"
//
//        //params[""] = ...
//
//        Alamofire.request( url + url_suff, method: .get, parameters: params ).responseJSON { response in
//            print("\n" + url_suff)
//            print(response)
//        }
//    }
    

    
//
//    func VKRequestPhotosGet() {
//        let url_suff = "photos.get/"
//        var params = Parameters()
//        params["user_ids"] = Session.instance.userID
//        params["access_token"] = Session.instance.token
//        params["v"] = version
//        params["fields"] = "nickname, country, photo_50"
//
//        //params[""] = ...
//
//        Alamofire.request( url + url_suff, method: .get, parameters: params ).responseJSON { response in
//            print("\n" + url_suff)
//            print(response)
//        }
//    }
    
    

    
    
    func loginRequest() {
        
    }
}



class TestViewController : UIViewController, WKNavigationDelegate {
    
    var wk: WKWebView = WKWebView()
    var api: API = API()
    let theURL = "https://api.vk.com/method/friends.get?user_ids=293104687&fields=bdate&access_token=0952aa9dc84b0a07fe8df167a89032fc7936daba75b4fb0b265cdfd90eab610618e2dfe8fe0eca2625a1a&v=5.103"
    //"https://api.vk.com/method/friends.get?access_token=" + "theGlobalToken" + "&fields=picture_50&lang=ru&count=100&version=5.69&"

    var url = "https://api.vk.com/method/"
    var version = "5.103"
    var client_id = 7342462
    let realm = try! Realm()
    var items: Results<RealmUser>!
    
    func openWKView() {
        let webConfiguration = WKWebViewConfiguration()
        wk = WKWebView(frame: .zero, configuration: webConfiguration)
        wk.uiDelegate = self
        wk.navigationDelegate = self
        view = wk
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      getFriendsDataBase()
        
     //   let api = API()
     //   api.VKRequest("groups.get")
     //   api.VKRequest("friends.get")
      //  api.VKRequest("photos.get")
       // api.loginRequest()
        


        let client_id = "client_id=7342462"
        let scope = "scope=friends"
        let response_type = "response_type=token"

      //  let vkURL = URL(string: "https://api.vk.com/method/friends.get?user_ids=293104687&fields=bdate&access_token=0952aa9dc84b0a07fe8df167a89032fc7936daba75b4fb0b265cdfd90eab610618e2dfe8fe0eca2625a1a&v=5.103")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           openWKView()
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=7342462&display=page&redirect_uri=https://oauth.vk.com/blank.html&display=page&scope=friends,wall,offline&response_type=token&v=5.103&state=123456")
       //  let url = URL(string:  "https://oauth.vk.com/authorize?client_id=1&display=page&redirect_uri=http://example.com/callback&group_ids=1,2&scope=messages&response_type=code&v=5.103")
        let myRequest = URLRequest(url: url!)
            wk.load(myRequest)

        //    getFriends()
    }
    
    func VKRequestGroupsGet() {
        let url_suff = "groups.get/"
        var params = Parameters()
        params["user_ids"] = Session.instance.userID
        params["access_token"] = Session.instance.token
        params["v"] = version
        params["extended"] = 1
        params["fields"] = "description, members_count, country"
        params["count"] = 20
        params["filter"] = "groups"
        
        Alamofire.request( url + url_suff, method: .get, parameters: params ).responseJSON { response in
            print(response)
            let json = JSON(response.value)
            print("VKRequestGroupsGet> json>", json)
            let items = json["response"]["items"]
            print("VKRequestGroupsGet> items>",items)
            self.parsGroups(json: items)
            print(response)
        }
    }
    
    func parsGroups(json: JSON) {
        print("parsGroups>", json)
        vkgroups.removeAll()
        if let list = Mapper<Group>().mapArray(JSONObject: json.object) {
            
            print("parsGroups>List.count>",list.count)
            vkgroups = list
            
            
            //// удаляем все записи по ReaLmGroup
            try! realm.write {
                let objectsToDelete = realm.objects(ReaLmGroup.self)
               
                realm.delete(objectsToDelete)
            }
            
            // добавляем новые записи из ВК в ReaLmGroup
            for group in list {
                let realmGroup = ReaLmGroup()
                
                realmGroup.name =  group.name
                realmGroup.id = group.id
                realmGroup.text =   group.description
                realmGroup.imageUrl = group.imageUrl
                
                try! realm.write {
                    realm.add(realmGroup)
                }
            }
            
        }
        print("parsGroups>friends.count>",vkgroups.count)
        
        print("realm.configuration.fileURL")
        print(realm.configuration.fileURL)
    }
    
    
    func VKRequestFriendsGet() {
        let url_suff = "friends.get/"
        var params = Parameters()
        params["user_ids"] = Session.instance.userID
        params["access_token"] = Session.instance.token
        params["v"] = version
        params["fields"] = "nickname, country, photo_50"
        params["filters"] = "photo_tag"
        params["source_ids"] = "pages"
        //params[""] = ...
        
        Alamofire.request( url + url_suff, method: .get, parameters: params ).responseJSON { response in
            print(response)
            let json = JSON(response.value)
            print("json>", json)
            let response = json["response"]
            print("response>",response)
            let items = response["items"]
            print("items>",items)
            self.parsUsers(json: items)
            print(response)
        }
    }
    
            func parsUsers(json: JSON) {
print("parsUsers>", json)
          friends.removeAll()
        if let list = Mapper<User>().mapArray(JSONObject: json.object) {
            print("list->cout>", list.count)
            for user in list {
                print("user>", user.name)
                let index = 0
                let firstCharacter = user.name[String.Index(encodedOffset: index)]
                friends.updateValue([user], forKey: firstCharacter)
            }
            
            
            try! realm.write {
                let objectsToDelete = realm.objects(RealmUser.self)
                // and then just remove the set with
                realm.delete(objectsToDelete)
            }
            
            for user in list {
                let realmUser = RealmUser()
    
                realmUser.first_name =  user.first_name
                realmUser.name =   user.name
                realmUser.photo_50 =  user.photo_50
                realmUser.last_name =  user.last_name
                
                try! realm.write {
                    realm.add(realmUser)
                }
            }
        }
        
        print("parsUsers>friends.count>",friends.count)
        print("realm.configuration.fileURL")
        print(realm.configuration.fileURL)
        
        //friends

        
        goHome()
    }
    
    
    func goHome(){
         performSegue(withIdentifier: "goHome", sender: nil)
    }
    func getFriends(){
        friends.removeAll()
        
        let api = API()
      VKRequestGroupsGet()
      VKRequestFriendsGet()
    //    api.VKRequestPhotosGet()
    }
    
    func getFriendsDataBase(){
        items = realm.objects(RealmUser.self)
        for item in items {
            let user = User()
            user.photos.append(UIImage(named: "photo1")!)
            user.first_name = item.first_name
            user.name = item.name
            user.last_name = item.last_name
            user.photo_50 = item.photo_50
            
            let index = 0
            let firstCharacter = user.name[String.Index(encodedOffset: index)]
            friends.updateValue([user], forKey: firstCharacter)
            
        }
        print("items.count>", items.count)
    }
    
}

extension TestViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView->WKUIDelegate")
        print(webView.url?.absoluteURL)
        print(webView.url?.absoluteString)
        let absoluteString =  webView.url!.absoluteString
        let url = URL(string:absoluteString)
        print(absoluteString)
        let expires_in = url!["expires_in"]
        if let access_token = url!["access_token"] {
            Session.instance.token = access_token
            getFriends()
        }
    }
}

func getQueryStringParameter(url: String, param: String) -> String? {
  guard let url = URLComponents(string: url) else { return nil }
  return url.queryItems?.first(where: { $0.name == param })?.value
}

extension URL {
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        if let parameters = url.queryItems {
            return parameters.first(where: { $0.name == queryParam })?.value
        } else if let paramPairs = url.fragment?.components(separatedBy: "?").last?.components(separatedBy: "&") {
            for pair in paramPairs where pair.contains(queryParam) {
                return pair.components(separatedBy: "=").last
            }
            return nil
        } else {
            return nil
        }
    }
}
