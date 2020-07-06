//
//  CustomNavigation.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 25.02.2020.
//  Copyright © 2020 Ermine Harutynyan. All rights reserved.
//

import UIKit

class CustomNavigation: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            return PopAnimator()
        case .push:
            return PushAnimator()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

