//
//  ViewController.swift
//  InterfaceDesignVK_1
//
//  Created by Ermine Harutynyan on 23.11.2019.
//  Copyright © 2019 Ermine Harutynyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLable: UIImageView!
    @IBOutlet weak var login_: UITextField!
    @IBOutlet weak var password_: UITextField!
    
    @IBAction func back(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideAction = UITapGestureRecognizer(target: self, action:#selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
        
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    

    @IBAction func pressButtons(_ sender: Any) {
        guard let loginInput = login_.text,
        let passwordInput = password_.text else {
            return
        }
//
//        print(loginInput + " " + passwordInput)
        
    }
}
