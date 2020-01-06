//
//  MyDataTableViewCell.swift
//  Assignment2Game
//
//  Created by Christopher Reynolds on 2019-11-27.
//  Copyright © 2019 Christopher Reynolds. All rights reserved.
//

import UIKit

class MyDataTableViewCell: UITableViewCell {

    @IBOutlet var myScore : UILabel!
    @IBOutlet var myLogo : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
