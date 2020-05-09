//
//  ViewController.swift
//  AttendanceAppKing
//
//  Created by marvin evins on 5/6/20.
//  Copyright © 2020 websavantmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roundButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundButton.layer.cornerRadius = 20.0
        roundButton.layer.masksToBounds = true
    }


}

