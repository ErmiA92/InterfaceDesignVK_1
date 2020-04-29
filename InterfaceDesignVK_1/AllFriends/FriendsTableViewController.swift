//
//  FriendsTableViewController.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 22.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    let realm = try! Realm()
    var realmUser: Results<RealmUser>!
    var token: NotificationToken?
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching: Bool = false
    var filtered: [User] = [User]()
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !(searchBar.text == "")
        if (isSearching) {
            guard let tmp = friends[Character(Array(searchBar.text!)[0].uppercased())] else {
                filtered.removeAll()
                tableView.reloadData()
                return
            }
            filtered = tmp.filter({
                $0.name.lowercased().prefix(searchBar.text!.count) == searchBar.text!.lowercased()
            })
        }
        tableView.reloadData() //
    }
    
    
    
    func getChar(_ id: Int) -> Character {
        let uniCode = UnicodeScalar("A")
        return Character(UnicodeScalar(uniCode.value + UInt32(id))!)
    }
    
    @objc func backToTheFuture() {
        performSegue(withIdentifier: "temp", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userObs = realm.objects(RealmUser.self)
               self.token = userObs.observe {  (changes: RealmCollectionChange) in
                   print("данные изменились")
                   self.getFriendsDataBase()
                   self.tableView.reloadData()
               }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                  self.addNewUser()
              }
                  
              DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                  self.addNewUser()
              }
        
        
        searchBar.delegate = self
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        btn.backgroundColor = UIColor.white
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(FriendsTableViewController.backToTheFuture), for: .touchDown)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        
        
        print("viewDidLoad")
        
        
       // getData()
    }
        
    
//    func getData(){
//        let url = "https://jsonplaceholder.typicode.com/users"
//
//        Alamofire.request(url).responseJSON { response in
//
//            let json = JSON(response.value)
//            self.parsUsers(json: json)
//
//            print("json>", json)
//        }
//    }
    
    

    
    
    //MARK: - Table view data source
    
       func getFriendsDataBase(){
           realmUser = realm.objects(RealmUser.self)
           //friends.removeAll()
           for realmUser in realmUser {
               let use = User()
               use.first_name   = realmUser.first_name
               use.name = realmUser.name
               use.last_name = realmUser.last_name
               use.photo_50 = realmUser.photo_50
               use.photos.append(UIImage(named: "barbi7")!)
               let index = 0
               let firstCharacter = use.name[String.Index(encodedOffset: index)]
               friends.updateValue([use], forKey: firstCharacter)
            
           }
           
       }
       
       func addNewUser(){
           let realmUser = RealmUser()
           realmUser.name =  "New Friend"
           realmUser.first_name = ""
           realmUser.last_name = "Неизвестно"
           realmUser.photo_50 = ""
           
           try! realm.write {
               realm.add(realmUser)
           }
       }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (friends[getChar(section)] == nil ||
            (isSearching && (filtered.count == 0 || (Character(Array(filtered[0].name)[0].uppercased()) != getChar(section)))))
        {
            return nil
        }
        return String(getChar(section))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (friends[getChar(section)] == nil ||
            (isSearching && (filtered.count == 0 || (Character(Array(filtered[0].name)[0].uppercased()) != getChar(section)))))
        {
            return 0
        }
        if (isSearching) {
            return filtered.count
        } else {
            return friends[getChar(section)]!.count
        }
    }

//    0 - a
//    1 - b
//    2 - c
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testcell", for: indexPath) as! FriendsTableViewCell
        
        var friend: User = User()
        
        if (isSearching) {
            friend = filtered[indexPath.row]
        } else {
            guard let users = friends[getChar(indexPath.section)] else { return cell }
            friend = users[indexPath.row]
        }
        
        cell.nameView.text = friend.name
        cell.photoView.imageView.image = friend.photos.first!
        
        return cell
    }
    
    
//}
    
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

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        if (segue.identifier == "getFriend") {
            guard let cont = segue.destination as? PhotoFriendCollectionViewController
            else {
                print("Error, bad ViewController", segue.destination)
                return
            }
//            мои заметки
//            indexPath.section - буква
//            indexPath.row - дает номер пользователя в его массиве
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // self.friends // список моих пользователей
                // indexPath.row // номер строки, которую я выбрала
                cont.friend = friends[getChar(indexPath.section)]![indexPath.row] //
            }
        }
    }
    // MARK: - Navigation
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addFriend" {
//
//            guard let friendsTableViewController = segue.source as? FriendsTableViewController else { return }
//
//        if let indexPath = friendsTableViewController.tableView.indexPathForSelectedRow {
//
//        let friend = friendsTableViewController.friends[indexPath.row]
//
//            if !friends.contains(friend) {
//
//            friends.append(friend)
//            tableView.reloadData()
//
//        }

        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//    }
    

}

