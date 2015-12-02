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
import Foundation
import CoreFoundation

class ContactTabelviewController: UITableViewController,CNContactPickerDelegate,UISearchDisplayDelegate,UISearchBarDelegate{
    var detailViewController : DetailsViewController? = nil
    var contacters = [CNContact]()
    var contacterBySearch = [CNContact]()
    var searchActive : Bool = false
    var fetchWord : [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    enum StringOrCNContact{
        case StringValue(String)
        case CNContactValue(CNContact)
        }
    var indexContact = [[StringOrCNContact]]()
    var copyIndexContact = [[StringOrCNContact]]()
    
    @IBOutlet weak var SearchBar: UISearchBar!

//MARK: - searchBar
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
                indexContact.removeAll()
                searchActive = false
            }else{                
                searchActive = false
            }
        }else {
            indexContact.removeAll()
            searchActive = true
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        self.indexContact = self.copyIndexContact
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        self.indexContact = self.copyIndexContact
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = true
    }
    
//MARK: - viewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionIndexColor = UIColor.blackColor()
        if let split = self.splitViewController{
            let controller = split.viewControllers
            self.detailViewController = (controller[controller.count - 1] as! UINavigationController).topViewController as? DetailsViewController
        }
        self.contacters = self.findContacters()
        let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
        dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            self.indexContact = self.indexContacter()
            dispatch_async( dispatch_get_main_queue()){
                self.copyIndexContact = self.indexContact
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

// MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchActive{
            return 1
        }else{
            return self.indexContact.count
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchActive {
            return self.contacterBySearch.count
        }else{
            let indexCount = indexContact[section].count - 1
            return indexCount
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifiyCell = "Cell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(identifiyCell, forIndexPath: indexPath) as! myCell
        //self.tableView.registerClass(myCell.self, forCellReuseIdentifier: identifiyCell)
        
        // Configure the cell...
        if (searchActive){
            let contacter = contacterBySearch[indexPath.row] as CNContact
            cell.textLabel?.text = "\(contacter.familyName)\(contacter.givenName)"
          
        }else{
            
            switch indexContact[indexPath.section][indexPath.item + 1] {
            case let .CNContactValue(s):
                cell.textLabel?.text = "\(s.familyName)\(s.givenName)"
            default:break
            }
        }
        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        if searchActive {
            return nil
        }else{
            return self.fetchWord
        }
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        var topIndex = 0
        for Character in self.fetchWord{
            if Character == title {
                return topIndex
            }
            topIndex++
        }
        return 0
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchActive {
            return nil
        }else{
            var returnString: String = ""
            var str : String = ""
            switch indexContact[section][0]{
            case let .StringValue(s):
                str = s
            default: break
            }

            for var i = 0;i <= 25;i++ {
                if str == self.fetchWord[i]{
                    returnString = str
                }
            }
            return returnString
        }
    }
    
// MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                switch indexContact[indexPath.section][indexPath.item + 1] {
                case let .CNContactValue(s):
                    let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailsViewController
                    controller.contact = s
                    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                default:break
                }
            }
        }
    }
    
// Thanks for 王巍！ 给我一些数组中写入不同类型变量的思想方式
// MARK: - indexContacter 
// 将索引字母与联系人构成一个二维数组
    func indexContacter() -> [[StringOrCNContact]]{
        var indexContacter = [[StringOrCNContact]]()
        var rowArray = [StringOrCNContact]()
        for contact in contacters{
            //将所得到的联系人名字转换成拼音，寻找首字母
            let stringFor : NSMutableString = NSMutableString(string: CNContactFormatter.stringFromContact(contact, style: .FullName)!)
            if CFStringTransform(stringFor,nil,kCFStringTransformMandarinLatin, false){//取得带音标的字符
                if CFStringTransform(stringFor,nil,kCFStringTransformStripDiacritics, false){ //取得不带音标的字符
                    let topIndex: String = stringFor as String
                    let index = topIndex.startIndex.advancedBy(1)
                    var firstLetter: String = topIndex.substringToIndex(index)
                    firstLetter = firstLetter.uppercaseString
                    firstLetter = FirstWord.polyphonicCharacter(contact, first: firstLetter)
                    //firstLetter = polyphonicCharacter(contact, first: firstLetter)
                    if rowArray.isEmpty{
                        rowArray.append(StringOrCNContact.StringValue(firstLetter))
                        rowArray.append(StringOrCNContact.CNContactValue(contact))
                    }else {
                        switch rowArray[0]{
                        case let .StringValue(s):
                            if s == firstLetter{
                                rowArray.append(StringOrCNContact.CNContactValue(contact))
                            }else {
                                indexContacter.append(rowArray)
                                rowArray.removeAll()
                                rowArray.append(StringOrCNContact.StringValue(firstLetter))
                                rowArray.append(StringOrCNContact.CNContactValue(contact))
                            }
                        default: break
                        }
                    }
                }
            }
            
        }
        indexContacter.append(rowArray)
        return indexContacter
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

    
}
