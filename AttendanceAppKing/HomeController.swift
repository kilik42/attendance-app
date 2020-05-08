//
//  HomeController.swift
//  AttendanceAppKing
//
//  Created by marvin evins on 5/6/20.
//  Copyright © 2020 websavantmedia. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         <#code#>
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         <#code#>
     }
     
    


}
