//
//  NewsTableViewCell.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 10.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet private weak var newsText: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsView: UILabel!
    
    @IBOutlet private weak var commentButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    
    var likeView: LikeView = LikeView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func shareButtonDown(_ sender: Any) {
        print("Share button down")
    }
    
    @IBAction private func commentButtonDown(_ sender: Any) {
        print("Comment button down")
    
    }
}
