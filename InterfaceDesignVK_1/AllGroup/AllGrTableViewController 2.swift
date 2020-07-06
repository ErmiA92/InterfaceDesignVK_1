//
//  AllGrTableViewController.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 24.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit
import RealmSwift

class AllGrTableViewController: UITableViewController {
    // это менеджер базы
    let realm = try! Realm()
    // это массив который возвращавет база
    var realmGroups: Results<ReaLmGroup>!
    /// это переменная для обсервера
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let grpsObs = realm.objects(ReaLmGroup.self)
        /// подписка на изменения данных в базе по ReaLmGroup
        //gj
        self.token = grpsObs.observe {  (changes: RealmCollectionChange) in
            print("данные изменилис")
            self.getGruupsDataBase()
            self.tableView.reloadData()
        }

        ///// для теста код добавляние новой группы через 5 сек
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.addNewGroups()
        }
            ///// для теста код добавляние новой группы через 10 сек
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.addNewGroups()
        }
    }
    
    
    // MARK: - Table view data source
    
    // получить все элементы ReaLmGroup в базе
    func getGruupsDataBase(){
        realmGroups = realm.objects(ReaLmGroup.self)
        vkgroups.removeAll()
        for realmGroup in realmGroups {
            let grp = Group()
            grp.name  = realmGroup.name
            grp.imageUrl = realmGroup.imageUrl
            grp.id = realmGroup.id
            grp.description = realmGroup.text
            vkgroups.append(grp)
        }
        
    }
    
    /// фунгкция для добавления в базе новой группы
    func addNewGroups(){
        let realmGroup = ReaLmGroup()
        realmGroup.name =  "Новая группа"
        realmGroup.id = 43
        realmGroup.text = "тестовая группа"
        realmGroup.imageUrl = ""
        
        try! realm.write {
            realm.add(realmGroup)
        }
    }
    
    
            
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vkgroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCells", for: indexPath) as! AllGrTableViewCell
        
        let obj = vkgroups[indexPath.row]
        
        cell.groupName.text = obj.name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        vkgroups.remove(at: indexPath.row)
            // Delete the row from the data source
        tableView.deleteRows(at: [indexPath], with: .fade)
       } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
   }


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

}
