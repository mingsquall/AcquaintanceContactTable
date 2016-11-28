//
//  MainTableViewController.swift
//  ContactTable
//
//  Created by Patientman on 2016/11/23.
//  Copyright © 2016年 mingSquall. All rights reserved.
//

import UIKit
import Foundation

class MainTableViewController: UITableViewController {
    
    //空数组
    var acqList = [PersonsMO]()
    
    var acqNames = ["Ameir Al-Zoubi", "Bill Dudney", "Bob McCune", "Brent Simmons", "Cesare Rocchi", "Chad Sellers", "Conrad Stoll", "Daniel Pasco", "Jaimee Newberry", "James Dempsey", "Josh Abernathy", "Justin Miller", "Ken Auer", "Kevin Harwood", "Kyle Richter", "Manton Reece", "Marcus Zarra", "Mark Pospesel", "Matt Drance", "Michael Simmons", "Michele Titolo", "Michael Simmons", "Rene Cacheaux", "Rob Napier", "Scott McAlister", "Sean McMains"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        /* 用了coredata以后 初始化不需要了
        for person in acqList {
            if let name = person?.personName {
                person?.personPhoto = UIImage(named: name)
                person?.personNote = "this is " + name
            }
        }
         */
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            if !FileManager().fileExists(atPath: PersonsMO.StoreURL.path) {
                for name in acqNames {
                    let person = appDelegate.addToContext(name: name, photo: UIImage(named: name), notes: nil)
                    acqList.append(person)
                }
            } else {
                if let fetchedList = appDelegate.fetchContext() {
                    acqList += fetchedList
                }
        }
    }
}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return acqList.count
    }

    
    // 行的检索包括行号和小节号： - 此处只用行号作为indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 重用 自定义的类ListCell 因此要做类型转换
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        
        let person = acqList[indexPath.row]
        
        // 数值为空的时候不赋值 不空的时候才做
        /*
        if let photo = person?.personPhoto {
            cell.photoImageView?.image = photo
        } else {
            cell.photoImageView.image = UIImage(named: "photoalbum")
        }
        cell.nameLabel.text = person?.personName
        cell.notesLabel.text = person?.personNote
        */
        if let photoData = person.photo {
            cell.photoImageView.image = UIImage(data: photoData as Data)
        } else {
            cell.photoImageView.image = UIImage(named: "photoalbum")
        }
        
        cell.nameLabel.text = person.name
        cell.notesLabel.text = person.notes
        
        return cell

    
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // 滑动删除 - Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 用户删除一行 要做两件事 表显示数组中的信息（一对一的）界面上删除一行 意味着数组中的一行也要删掉
        if editingStyle == .delete {
            // Delete the row from the data source
            // 删除数组
            let person = acqList[indexPath.row]
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                appDelegate.deleteFromContext(person: person)
                acqList.remove(at: indexPath.row)
                // 删除界面中的一行
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" , let destVC = segue.destination as? DetailTableViewController, let indexPath = tableView.indexPathForSelectedRow{
            // if let 确保用户选择的那一行数据是可用的（有效的）
            let person = acqList[indexPath.row]
            destVC.person = person
            
        }
    }
    
    @IBAction func saveToList(segue: UIStoryboardSegue) {
        if segue.identifier == "saveToList",
            let detailTableViewController = segue.source as? DetailTableViewController,
            let person = detailTableViewController.person {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing person
                acqList[(selectedIndexPath as NSIndexPath).row] = person
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new person.
                let newIndexPath = IndexPath(row: acqList.count, section: 0)
                acqList.append(person)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
}







