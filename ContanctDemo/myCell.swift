//
//  myCell.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/10/29.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class myCell: UITableViewCell {

    @IBOutlet weak var contactCell: UILabel!
    
    func update(){
        contactCell.text = nil
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
