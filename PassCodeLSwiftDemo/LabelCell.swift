//
//  LabelCell.swift
//  PassCodeLSwiftDemo
//
// Created by s-sakurai on 2017/04/07.
//  Copyright © 2017年 s-sakurai. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleValue:String{
        get{
            return titleLabel.text!
        }
        set(value){
            titleLabel.text = value
        }
    }
}

