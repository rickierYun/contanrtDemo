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
 
    @IBOutlet weak var contactImage: UIImageView!{
        didSet{
            //设置图片为圆形
            self.contactImage.layer.cornerRadius = self.contactImage.frame.size.width / 2
            self.contactImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var mobile: UILabel!
    
    @IBAction func callPhone(sender: UIButton) {       
        let phoneNumber = self.contactPhoneNumber.text! as String
        let telUrl = "tel://" + "\(phoneNumber)" as String
        let url = NSURL(string: telUrl)!
        UIApplication.sharedApplication().openURL(url)
    }
   
    @IBAction func messageButton(sender: UIButton) {
        let messageNumber = self.contactPhoneNumber.text! as String
        let smsNumber = "sms://" + "\(messageNumber)" as String
        let url = NSURL(string: smsNumber)!
        UIApplication.sharedApplication().openURL(url)
    }
    
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
            }
            
            if let phoneNumberLable = self.contactPhoneNumber{
                for number in contact.phoneNumbers{
                    let lable = number.label
                    let phoneNumber = number.value as! CNPhoneNumber
                    if lable == "_$!<Mobile>!$_" {
                        phoneNumberLable.text = phoneNumber.stringValue
                    }
                }
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
