//
//  ContactDetailsController.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/11/17.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactDetailsController: UITableViewController {
    
    var contacters = [CNContact]()
    var contact: CNContact? {
        didSet{
            self.fetch()
        }
    }
    
    func fetch() -> CNContact {
        var contacter = self.contact
        if contacter != nil{
            return contacter!
        }else {
            self.contacters = self.findContacters()
            contacter = contacters[0]
            return contacter!
        }
        
    }

    func findContacters() ->[CNContact]{
        let store = CNContactStore()
        
        let keyToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactImageDataKey,CNContactPhoneNumbersKey]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keyToFetch)
        
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
                contacts.append(contact)
            })
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return contacts
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let nameCell = "nameCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(nameCell, forIndexPath: indexPath) as! NameCell
        let data = contact?.imageData
        if data != nil{
            cell.imageOfName.image = UIImage(data: data!)
        }
        cell.nameLable.text = "\(contact?.givenName)" + "\(contact?.familyName)"

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
