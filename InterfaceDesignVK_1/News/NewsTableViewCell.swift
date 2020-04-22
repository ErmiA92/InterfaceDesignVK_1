//
//  NewsTableViewCell.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 10.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsView: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var likeView: LikeView = LikeView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareButtonDown(_ sender: Any) {
        print("Share button down")
    }
    
    @IBAction func commentButtonDown(_ sender: Any) {
        print("Comment button down")
    
    }
}
