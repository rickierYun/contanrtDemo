//
//  DetailsViewController.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/10/27.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import Contacts

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var phoneNumbers = [[String]]()
    var contact: CNContact? {
        didSet{
            self.fetchView()
        }
        
    }

    @IBOutlet weak var contactImage: UIImageView!{
        didSet{
            //设置图片为圆形
            self.contactImage.layer.cornerRadius = self.contactImage.frame.size.width / 2
            self.contactImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var tableViewForNumber: UITableView!
    @IBOutlet weak var contactName: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchView()
        if contact != nil {
            self.tableViewForNumber.delegate = self
            self.tableViewForNumber.dataSource = self
            findDifNumbers()
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
        if let contact = self.contact{
            if let lable = self.contactName{
                lable.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
            }
            
            if let image = self.contactImage{
                if contact.imageData != nil{
                    image.image = UIImage(data: contact.imageData!)
                }
            }
        }
    }
    
   
//MARk: - table View Data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contact?.phoneNumbers.count)!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identife = "phoneCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identife, forIndexPath: indexPath) as! PhoneNumberCell
        if phoneNumbers.isEmpty == false{
            print(phoneNumbers[indexPath.row][indexPath.section])
            switch phoneNumbers[indexPath.row][indexPath.section] {
            case "_$!<Home>!$_" :
                cell.homeLable.text = "住宅电话"
                cell.numberLable.text = phoneNumbers[indexPath.row][1]
            case "_$!<Mobile>!$_":
                cell.homeLable.text = "移动电话"
                cell.numberLable.text = phoneNumbers[indexPath.row][1]
            case "iPhone":
                cell.homeLable.text = "iPhone"
                cell.numberLable.text = phoneNumbers[indexPath.row][1]
            case "_$!<Other>!$_":
                cell.homeLable.text = "其他"
                cell.numberLable.text = phoneNumbers[indexPath.row][1]
            default :break
            }
            
//            if phoneNumbers[indexPath.row][indexPath.section] == "_$!<Home>!$_"{
//
//            }
//            if phoneNumbers[indexPath.row][indexPath.section] == {
//
//
//            }
        }
        return cell
    }
    func findDifNumbers() {
        if contact != nil{
            for number in (contact?.phoneNumbers)! {
                var phones = [String]()
                let lable = number.label
                phones.append(lable)
                let phoneNumber = number.value as! CNPhoneNumber
                let phoneNumberString = phoneNumber.stringValue
                phones.append(phoneNumberString)
                phoneNumbers.append(phones)
                
            }
        }
    }
  
}
