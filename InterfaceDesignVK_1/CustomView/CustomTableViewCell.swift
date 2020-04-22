//
//  CustomTableViewCell.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 07.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCustom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
