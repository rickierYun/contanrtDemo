//
//  DetailsViewController.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/10/27.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import Contacts

class DetailsViewController: UIViewController {
 
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactPhoneNumber: UILabel!
    var contact: CNContact? {
        didSet{
            self.fetchView()
        }
        
    }
    
//MARK: - fetchView
    func fetchView()
    {
        if let contact = self.contact{
            if let lable = self.contactName{
                lable.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
            }
            
            if let image = self.contactImage{
                if contact.imageData != nil{
                    image.image = UIImage(data: contact.imageData!)
                }
                else {
                    image.image = nil
                }
            }
            
            if let phoneNumberLable = self.contactPhoneNumber{
                var numberArry = [String]()
                for number in contact.phoneNumbers{
                    let phoneNumber = number.value as! CNPhoneNumber
                    numberArry.append(phoneNumber.stringValue)
                }
                phoneNumberLable.text = numberArry.joinWithSeparator(",")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
