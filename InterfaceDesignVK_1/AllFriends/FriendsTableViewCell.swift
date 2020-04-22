//
//  FriendsTableViewCell.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 21.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    var nameView: UILabel = UILabel()
    var photoView: ProfilePhotoView = ProfilePhotoView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
        let tmp = self.contentView.frame.height
        photoView = ProfilePhotoView(frame: CGRect(x: contentView.frame.width - tmp * 1.4, y: tmp * 0.1, width: tmp * 0.8, height: tmp * 0.8))
        contentView.addSubview(photoView)
        
        nameView = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width - tmp * 1.5, height: contentView.frame.height))
        nameView.textAlignment = .center
        contentView.addSubview(nameView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
