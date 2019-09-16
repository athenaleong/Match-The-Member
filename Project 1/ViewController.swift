//
//  ViewController.swift
//  Project 1
//
//  Created by Athena Leong on 9/13/19.
//  Copyright © 2019 Athena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toPlay" , sender: self)
    }
    
}

