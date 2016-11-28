//
//  DetailTableViewController.swift
//  ContactTable
//
//  Created by Patientman on 2016/11/24.
//  Copyright © 2016年 mingSquall. All rights reserved.
//

import UIKit
import Foundation


class DetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // 添加新的人的时候也可能为空
    var person: PersonsMO?
    

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var notesTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        /*if let photo = person?.personPhoto {
            photoImageView.image = photo
        } else {
            photoImageView.image = UIImage(named:"photoalbum")
        }
        nameTextField.text = person?.personName
        
        notesTextField.text = person?.personNote
         */
        if let photoData = person?.photo {
            photoImageView.image = UIImage(data: photoData as Data)
        } else {
            photoImageView.image = UIImage(named: "photoalbum")
        }
        nameTextField.text = person?.name
        notesTextField.text = person?.notes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 在detail中准备数据
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "returnToList" {
//            if person == nil {
//                person = person(nameTextField.text!)
//            } else {
//                person?.personName = nameTextField.text!
//            }
//            person!.personPhoto = photoImageView.image
//            person!.personNote = notesTextField.text
//            
//        }
        
        // Get the new view controller using segue.destinationViewController
        // Pass the selected object to the new view controller
        if segue.identifier == "saveToList", let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        {
            let name = nameTextField.text!
            let photo = photoImageView.image
            let notes = notesTextField.text
            
            if person == nil { // add a new entry
                // 添加一个新的人
                self.person = appDelegate.addToContext(name: name, photo: photo, notes: notes)
            } else { //updating 存在的那个人
                appDelegate.updateToContext(person: person!, name: name, photo: photo, notes: notes)
            }
        }
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController{
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
     @IBAction func save(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty  else {
            let alertController = UIAlertController(title: "Error", message: "name can't empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        performSegue(withIdentifier: "saveToList", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1,
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { // photo's section
            // 启动图片库
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 */
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


