//
//  LoadingIndicator.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 16.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import Foundation
import UIKit

typealias CGF = CGFloat

class LoadingIndicator: UIView {
    var points: [UIView] = [UIView]()
    var isFinished: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let sz = min(frame.height, frame.width / CGF(5)) // 0 complention
        
        for i in 0..<3 {
            let point = UIView(frame: CGRect(x: CGF(i) * CGF(2) * sz, y: CGFloat(0), width: sz, height: sz))
            point.layer.cornerRadius = sz / 2
            point.backgroundColor = UIColor.gray
            points.append(point)
            addSubview(points.last!)
        }
        startAnimation(dur: 3)
    }
    
    func startAnimation(dur: Double) {
        UIView.animateKeyframes(withDuration: dur, delay: 0, options: [.calculationModeLinear], animations: {
            // Add animations
            for i in 0..<3 {
                UIView.addKeyframe(withRelativeStartTime: Double(i) * (1 / 6.0), relativeDuration: 1.0 / 6.0, animations: {
                    self.points[i].backgroundColor = UIColor.gray.withAlphaComponent(0.25)
                })
            }
            for i in 0..<3 {
                UIView.addKeyframe(withRelativeStartTime: 0.5 + Double(i) * (1 / 6.0), relativeDuration: 1.0 / 6.0, animations: {
                    self.points[i].backgroundColor = UIColor.gray.withAlphaComponent(1)
                })
            }
        }, completion: { _ in
            if (!self.isFinished) {
                self.startAnimation(dur: 3)
            } else {
                self.removeFromSuperview()
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
