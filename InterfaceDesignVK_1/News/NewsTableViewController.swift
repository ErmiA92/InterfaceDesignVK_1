//
//  NewsTableViewController.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 12.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import RealmSwift



class NewsTableViewController: UITableViewController {
    // это менеджер базы
    let realm = try! Realm()
    // это массив который возвращавет база
    var realmNewss: Results<RealmNews>!
    var token: NotificationToken?
    
    @IBOutlet var newsTable: UITableView!
    
    var news = [News] ()
    var url = "https://api.vk.com/method/"
    var version = "5.103"
    var client_id = 7342462
    //let realm = try! Realm()
    var items: Results<RealmUser>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nwObs = realm.objects(RealmNews.self)
        self.token = nwObs.observe { (changes: RealmCollectionChange) in
            print("данные изменились")
            self.getNewsDataBase()
            self.tableView.reloadData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.addNewNews()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.addNewNews()
        }
        
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell") //регистрация ячейки xib
        
        
        news = [
            News(text: news1, image: UIImage(named: "Parasite")!, views: 889),
            News(text: news1, image: UIImage(named: "Parasite")!, views: 889)
        ]

        vkRequestNewsGet()
    }

    
    func vkRequestNewsGet() {
        let url_suff = "newsfeed.get/"
        var params = Parameters()
        params["access_token"] = Session.instance.token
        params["v"] = version
        params["count"] = 5
        params["source_ids"] = "pages"
        //params[""] = ...
        //filters=post&count=1
        
        print("Session.instance.token>", Session.instance.token)
        
        Alamofire.request( url + url_suff, method: .get, parameters: params ).responseJSON { response in
            print(response)
            let json = JSON(response.value)
            let response = json["response"]
            self.parsUsers(response: response)
            //print(response)
        }
    }
    
    func parsUsers(response: JSON) {
        print("parsUsers>", response)
        news.removeAll()
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.tableView.reloadData()
        }
        
        print("parsUsers>friends.count>",news.count)
        for new in news {
            let realmNews = RealmNews()
            
            realmNews.text =  new.text
            realmNews.imageUrl =   new.imageUrl
            realmNews.views =   new.views
            
            try! realm.write {
                realm.add(realmNews)
            }
        }
    }
    
    // MARK: - Table view data source

    func getNewsDataBase(){
           realmNewss = realm.objects(RealmNews.self)
           news.removeAll()
           for realmNews in realmNewss {
               let nw = News()
               nw.views  = realmNews.views
               nw.imageUrl = realmNews.imageUrl
               nw.text = realmNews.text
               news.append(nw)
        }
    }
    
    func addNewNews(){
        let realmNews = RealmNews()
        realmNews.views =  0
        realmNews.imageUrl = ""
        realmNews.text = "Новая публикация"
        
        try! realm.write {
            realm.add(realmNews)
        }
    }
            
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let item = news[indexPath.row]
        
        cell.newsText?.text = item.text
        cell.newsImage?.image = cropToBounds(image: item.image!, width: 280, height: 280) //доступ к элементам
        cell.newsView?.text = String.init(item.views)

        return cell
    }
}

    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

       let cgimage = image.cgImage!
       let contextImage: UIImage = UIImage(cgImage: cgimage)
       let contextSize: CGSize = contextImage.size
       var posX: CGFloat = 0.0
       var posY: CGFloat = 0.0
       var cgwidth: CGFloat = CGFloat(width)
       var cgheight: CGFloat = CGFloat(height)
        
    if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }
            
            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
            

            let imageRef: CGImage = cgimage.cropping(to: rect)!
            
            
            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
            
            return image
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


