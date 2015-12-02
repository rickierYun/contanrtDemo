//
//  polyphonicCharacter.swift
//  ContanctDemo
//
//  Created by 欧阳云慧 on 15/12/1.
//  Copyright © 2015年 欧阳云慧. All rights reserved.
//

import Foundation
import Contacts
class polyphonicCharacter {
    internal func polyphonicCharacter(contact: CNContact, var first: String) -> String {
            switch contact.familyName {
            case "沈" :
                first = "S"
            case "乐":
                first = "Y"
            case "种":
                first = "Z"
            case "单":
                first = "S"
            case "解":
                first = "X"
            case "查":
                first = "Z"
            case "曾":
                first = "Z"
            case "区":
                first = "O"
            case "繁":
                first = "P"
            case "仇":
                first = "C"
            case "幺":
                first = "Y"
            case "折":
                first = "S"
            case "晁":
                first = "C"
            case "贾":
                first = "J"
            case "馮":
                first = "F"
            case "哈":
                first = "H"
            case "尾":
                first = "W"
            case "盛":
                first = "S"
            case "塔":
                first = "T"
            case "谷":
                first = "G"
            case "乾":
                first = "Q"
            case "乜":
                first = "N"
            case "陶":
                first = "T"
            case "阚":
                first = "K"
            case "叶":
                first = "Y"
            case "车":
                first = "C"
            case "艾":
                first = "A"
            default: break
            }
            return first
        }
}