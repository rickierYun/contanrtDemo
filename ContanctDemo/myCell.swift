//
//  myCell.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/10/29.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import UIKit

class myCell: UITableViewCell {

    @IBOutlet weak var contactCell: UILabel!
//    @IBOutlet var cellLable :UILabel!
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
