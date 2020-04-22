//
//  PhotoFriendCollectionViewCell.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 27.01.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class PhotoFriendCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var friendname: UILabel = UILabel()
    var friendphotos: UIScrollView = UIScrollView()
    var likeView: LikeView = LikeView()
    var isCreated: Bool = false
    var offset: CGPoint = CGPoint()
    var currentPhoto: Int = 0
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tmp = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        scrollView.contentOffset = offset
        if (tmp.x < 0) {
            if (self.offset.x + scrollView.frame.width < scrollView.contentSize.width) {
                if (scrollView.isUserInteractionEnabled) {
                    print(scrollView.isUserInteractionEnabled)
                    scrollView.isUserInteractionEnabled = false
                    self.offset.x += scrollView.frame.width
                    UIView.animate(withDuration: 1, animations: {
                        scrollView.subviews[self.currentPhoto].transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        scrollView.contentOffset = self.offset
                    }, completion: { (finished: Bool) in
                        self.currentPhoto += 1
                        scrollView.isUserInteractionEnabled = true
                    })
                }
            }
        } else if (tmp.x > 0) {
            if (self.offset.x - scrollView.frame.width >= 0) {
                if (scrollView.isUserInteractionEnabled) {
                    scrollView.isUserInteractionEnabled = false
                    self.offset.x -= scrollView.frame.width
                    UIView.animate(withDuration: 1, animations: {
                        scrollView.contentOffset = self.offset
                        scrollView.subviews[self.currentPhoto - 1].transform = CGAffineTransform(scaleX: 1, y: 1)
                    }, completion: { (finished: Bool) in
                        self.currentPhoto -= 1
                        scrollView.isUserInteractionEnabled = true
                    })
                }
            }
        }
    }
    
    func addPhoto(_ photo: UIImage) {
        let photoView = UIImageView(frame: CGRect(
            x: friendphotos.contentSize.width,
            y: 0,
            width: friendphotos.frame.width,
            height: friendphotos.frame.height)
        )
        photoView.image = photo
        friendphotos.contentSize = CGSize(width: friendphotos.contentSize.width + photoView.frame.width, height: friendphotos.frame.height)
//        friendphotos.isScrollEnabled = false
        friendphotos.addSubview(photoView)
    }
    
    func resetCell(frame: CGRect, name: String, photos: [UIImage]) {
        
        if (!isCreated) {
            self.frame = frame
            self.contentView.frame = frame
            layoutSubviews()
            
            self.friendname = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 30))
            contentView.addSubview(friendname)
            
            self.friendphotos = UIScrollView(frame: CGRect(x: 0, y: 30, width: contentView.frame.width, height: contentView.frame.height - 60))
            self.friendphotos.delegate = self
//            self.friendphotos.backgroundColor = UIColor.yellow
//            self.friendphotos.isPagingEnabled = true
            for photo in photos {
                addPhoto(photo)
            }
            contentView.addSubview(friendphotos)
            
            self.likeView = LikeView(frame: CGRect(x: 0, y: friendphotos.frame.maxY, width: 100, height: 30))
            contentView.addSubview(likeView)
            
            isCreated = true
        }
        
        self.friendname.text = name
//        self.friendphoto.image = photo
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
