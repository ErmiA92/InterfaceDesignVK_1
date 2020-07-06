//
//  AllGrTableViewCell.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 25.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class AllGrTableViewCell: UITableViewCell {
    @IBOutlet weak var groupNameN: UILabel!
    
    @IBOutlet weak var groupName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
