//
//  PhoneNumberCell.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/11/18.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class PhoneNumberCell: UITableViewCell {

    @IBOutlet weak var homeLable: UILabel!
    @IBOutlet weak var numberLable: UILabel!
    
    @IBAction func sendMessage(sender: UIButton) {
        let phoneNumber = self.numberLable.text! as String
        let telUrl = "sms://" + "\(phoneNumber)" as String
        let url = NSURL(string: telUrl)!
        UIApplication.sharedApplication().openURL(url)
    }
  
    @IBAction func callBut(sender: UIButton) {
        let phoneNumber = self.numberLable.text! as String
        let telUrl = "tel://" + "\(phoneNumber)" as String
        let url = NSURL(string: telUrl)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
