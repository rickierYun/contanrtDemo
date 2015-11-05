//
//  AddressBook.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/10/27.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactTabelviewController: UITableViewController,CNContactPickerDelegate,UISearchDisplayDelegate,UISearchBarDelegate{
    var detailViewController : DetailsViewController? = nil
    var contacters = [CNContact]()
    var contacterBySearch = [CNContact]()
    var searchActive : Bool = false
    
    @IBOutlet weak var SearchBar: UISearchBar!

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.contacters = self.findContacters()
        contacterBySearch = []
        contacterBySearch = contacters.filter { (CNContactFormatter) -> Bool in
            let tmp : NSString = CNContactFormatter.familyName + CNContactFormatter.givenName
            let rang = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return rang.location != NSNotFound
        }
        
        if contacterBySearch.count == 0 {
            if searchText != "" {
                contacters.removeAll()
                searchActive = false
            }else{                
                searchActive = false
            }
        }else {
            contacters.removeAll()
            searchActive = true
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        self.contacterBySearch = self.contacters
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        self.contacters = self.findContacters()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let split = self.splitViewController{
            let controller = split.viewControllers
            self.detailViewController = (controller[controller.count - 1] as! UINavigationController).topViewController as? DetailsViewController
        }
        self.contacters = self.findContacters()
    }
    // MARK: - findContacters
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchActive {
            return self.contacterBySearch.count
        }else{
            return self.contacters.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifiyCell = "Cell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifiyCell, forIndexPath: indexPath) as! myCell
        //self.tableView.registerClass(myCell.self, forCellReuseIdentifier: identifiyCell)
        
        // Configure the cell...
        if (searchActive){
            let contacter = contacterBySearch[indexPath.row] as CNContact
            print("\(contacter)")
            cell.textLabel?.text = "\(contacter.familyName)\(contacter.givenName)"
          
        }else{
            let contacter = contacters[indexPath.row] as CNContact
            cell.textLabel?.text = "\(contacter.familyName)\(contacter.givenName)"
        }
        return cell
    }
    
    //MARK: - showDetails
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = contacters[indexPath.row] as CNContact
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailsViewController
                controller.contact = contact
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
   /* override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            contacterBySearch.removeAtIndex(indexPath.row)
            
//            NSUserDefaults.standardUserDefaults().setObject(contacterBySearch, forKey: "Contacters")
//            NSUserDefaults.standardUserDefaults().synchronize()
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

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
