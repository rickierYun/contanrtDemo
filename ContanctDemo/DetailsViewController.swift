//
//  DetailsViewController.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/10/27.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class DetailsViewController: UIViewController,UITableViewDelegate,CNContactViewControllerDelegate {
 
    private var store = CNContactStore()
    var contact: CNContact? {
        didSet{
            self.fetchView()
        }
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchView()
        if contact != nil {
            showContactViewController()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: - fetchView
    func fetchView()
    {
        _ = self.contact
    }
    
    private func showContactViewController() {
        // Search for the person named "Appleseed" in the Contacts
        let name = contact?.familyName
        let predicate: NSPredicate = CNContact.predicateForContactsMatchingName(name!)
        let descriptor = CNContactViewController.descriptorForRequiredKeys()
        let contacts: [CNContact]
        do {
            contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: [descriptor])
        } catch {
            contacts = []
        }
        // Display "Contact" information if found in the address book
        if !contacts.isEmpty {
            let contact = contacts[0]
            let cvc = CNContactViewController(forContact: contact)
            cvc.delegate = self
            // Allow users to edit the person’s information
            cvc.allowsEditing = true
            //cvc.contactStore = self.store //seems to work without setting this.
            self.navigationController?.pushViewController(cvc, animated: true)
        } else {
            // Show an alert if Contact" is not in Contacts
            let alert = UIAlertController(title: "Error",
                message: "Could not find \(name) in the Contacts application.",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
  
}
