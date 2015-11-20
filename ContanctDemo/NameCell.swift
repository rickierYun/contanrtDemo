//
//  nameCell.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/11/17.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var imageOfName: UIImageView!{
        didSet{
            self.imageOfName.layer.cornerRadius = self.imageOfName.frame.width / 2
            self.imageOfName.clipsToBounds = true
        }
    }

    @IBOutlet weak var nameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
